"""
    fgo_online(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas,
               Bx, By, Bz, dt, itp_mapS, x0_TL, P0, Qd, R;
               baro_tau       = 3600.0,
               acc_tau        = 3600.0,
               gyro_tau       = 3600.0,
               fogm_tau       = 600.0,
               date           = get_years(2020,185),
               core::Bool     = false,
               terms          = [:permanent,:induced,:eddy,:bias],
               Bt_scale       = 50000,
               robust::Symbol = :none,
               robust_c       = 0,
               n_iter         = 5,
               tol            = 1e-4,
               silent         = true)

Factor graph optimization (FGO) with batch estimation of Tolles-Lawson
coefficients (aeromagnetic compensation states).

The Tolles-Lawson coefficients are appended to the Pinson error states as
variables of the factor graph (compensation factors), mirroring the state
augmentation of [`ekf_online`](@ref), and the measurement factor becomes

    meas_t = A_t' x_TL + map(lat_t,lon_t,alt_t) + S_t (+ IGRF core)

where `A_t` is the Tolles-Lawson matrix row from the vector magnetometer (see
[`create_TL_A`](@ref)) and `S_t` is the FOGM catch-all state. A prior factor
centered on `x0_TL` (with covariance from `P0`) anchors the coefficients, and
the process factors (with driving noise from `Qd`, i.e., `TL_sigma`) allow
them to vary slowly in flight. Unlike the sequential [`ekf_online`](@ref),
the batch solution estimates the compensation jointly over the **whole**
flight, so early navigation states benefit from calibration information that
only becomes observable later (e.g., after maneuvers).

The maximum a posteriori (MAP) estimate is computed with an iterated
fixed-interval (Rauch–Tung–Striebel) smoother, i.e., Gauss–Newton on the
factor graph chain (see [`fgo`](@ref)). Optional robust (M-estimator)
measurement kernels are applied with iteratively reweighted least squares.

**Arguments:**
- `lat`:          latitude  [rad]
- `lon`:          longitude [rad]
- `alt`:          altitude  [m]
- `vn`:           north velocity [m/s]
- `ve`:           east  velocity [m/s]
- `vd`:           down  velocity [m/s]
- `fn`:           north specific force [m/s^2]
- `fe`:           east  specific force [m/s^2]
- `fd`:           down  specific force [m/s^2]
- `Cnb`:          direction cosine matrix (body to navigation) [-]
- `meas`:         scalar magnetometer measurement [nT]
- `Bx`,`By`,`Bz`: vector magnetometer measurements [nT]
- `dt`:           measurement time step [s]
- `itp_mapS`:     scalar map interpolation function (`f(lat,lon)` or `f(lat,lon,alt)`)
- `x0_TL`:        initial Tolles-Lawson coefficient states
- `P0`:           initial covariance matrix
- `Qd`:           discrete time process/system noise matrix
- `R`:            measurement (white) noise variance
- `baro_tau`:     (optional) barometer time constant [s]
- `acc_tau`:      (optional) accelerometer time constant [s]
- `gyro_tau`:     (optional) gyroscope time constant [s]
- `fogm_tau`:     (optional) FOGM catch-all time constant [s]
- `date`:         (optional) measurement date (decimal year) for IGRF [yr]
- `core`:         (optional) if true, include core magnetic field in measurement
- `terms`:        (optional) Tolles-Lawson terms to use {`:permanent`,`:induced`,`:eddy`,`:bias`}
- `Bt_scale`:     (optional) scaling factor for induced & eddy current terms [nT]
- `robust`:       (optional) robust measurement kernel {`:none`,`:huber`,`:cauchy`}
- `robust_c`:     (optional) robust kernel tuning constant, `0` for default (`1.345` Huber, `2.385` Cauchy)
- `n_iter`:       (optional) maximum number of Gauss–Newton (relinearization/IRLS) iterations
- `tol`:          (optional) convergence tolerance on the RMS smoothed state change between iterations
- `silent`:       (optional) if true, no print outs

**Returns:**
- `filt_res`: `FILTres` filter (smoother) results struct
"""
function fgo_online(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas,
                    Bx, By, Bz, dt, itp_mapS, x0_TL, P0, Qd, R;
                    baro_tau       = 3600.0,
                    acc_tau        = 3600.0,
                    gyro_tau       = 3600.0,
                    fogm_tau       = 600.0,
                    date           = get_years(2020,185),
                    core::Bool     = false,
                    terms          = [:permanent,:induced,:eddy,:bias],
                    Bt_scale       = 50000,
                    robust::Symbol = :none,
                    robust_c       = 0,
                    n_iter         = 5,
                    tol            = 1e-4,
                    silent         = true)

    @assert robust in (:none,:huber,:cauchy) "robust kernel $robust not defined"

    N      = length(lat)
    ny     = size(meas,2)
    nx     = size(P0,1)
    nx_TL  = length(x0_TL)
    nx_vec = nx - 18 - nx_TL

    @assert nx_vec == 0 "vector magnetometer states not supported for fgo_online"

    length(R) == 2 && (R = mean(R)) # adaptive R not supported, use mean
    Rs = mean(R)

    robust_c == 0 && (robust_c = robust == :cauchy ? 2.385 : 1.345)

    A = create_TL_A(Bx,By,Bz;
                    terms    = terms,
                    Bt_scale = Bt_scale)

    map_cache = itp_mapS isa Map_Cache ? itp_mapS : nothing

    # Pinson transition matrices (t -> t+1); TL states propagate as identity
    Phi_a = zeros(eltype(P0),nx,nx,N-1)
    for t = 1:(N-1)
        Phi_a[:,:,t] = get_Phi(nx,lat[t],vn[t],ve[t],vd[t],fn[t],fe[t],fd[t],
                               Cnb[:,:,t],baro_tau,acc_tau,gyro_tau,fogm_tau,dt)
    end

    # per-time-step map interpolation functions (resolve map cache once)
    itps = map_cache isa Map_Cache ?
           [get_cached_map(map_cache,lat[t],lon[t],alt[t];silent=true) for t = 1:N] :
           fill(itp_mapS,N)

    # prior mean: zero Pinson errors, x0_TL compensation coefficients
    x0 = zeros(eltype(P0),nx)
    x0[18:17+nx_TL] = x0_TL

    # expected measurement & Jacobian at reference states x_bar [nx x N]
    # h(x) = A_t' x_TL + map(pos) + S (+ core); Jacobian per ekf_online
    function meas_model(x_bar)
        h_bar = zeros(eltype(P0),N)
        H_bar = zeros(eltype(P0),nx,N)
        for t = 1:N
            xb   = x_bar[:,t]
            x_TL = xb[18:17+nx_TL]
            h_bar[t] = (A[t,:]'*x_TL .+
                        get_h(itps[t],xb,lat[t],lon[t],alt[t];
                              date=date,core=core))[1]
            Hll = get_H(itps[t],xb,lat[t],lon[t],alt[t];date=date,core=core)
            H_bar[:,t] = [Hll[1:2]; zeros(eltype(P0),nx-3-nx_TL); A[t,:]; 1]
        end
        return (h_bar, H_bar)
    end

    x_smooth = repeat(x0,1,N) # initial linearization reference
    P_smooth = zeros(eltype(P0),nx,nx,N)
    w        = ones(eltype(P0),N) # IRLS measurement weights

    for iter = 1:n_iter

        x_bar = copy(x_smooth) # relinearize about previous solution
        (h_bar,H_bar) = meas_model(x_bar)

        # IRLS robust weight update from whitened residuals at x_bar
        if (robust != :none) & (iter > 1)
            for t = 1:N
                e    = abs(mean(meas[t,:]) - h_bar[t]) / sqrt(Rs)
                w[t] = clamp(robust_weight(e,robust,robust_c),1e-6,1)
            end
        end

        (x_smooth,P_smooth) = fgo_rts_pass(x_bar,h_bar,H_bar,Phi_a,meas,
                                           P0,Qd,R,w,ny;x0=x0)

        # convergence check on the RMS change of the smoothed states
        dx = sqrt(mean(abs2, x_smooth .- x_bar))
        silent || @info("fgo_online iter $iter: Δx_rms = $(round(dx,sigdigits=3))")
        (iter > 1) && (dx < tol) && break
    end

    # post-fit (nonlinear) measurement residuals at the smoothed estimate
    r_out = zeros(eltype(P0),ny,N)
    (h_fit,_) = meas_model(x_smooth)
    for t = 1:N
        r_out[:,t] = meas[t,:] .- h_fit[t]
    end

    return FILTres(x_smooth, P_smooth, r_out, true)
end # function fgo_online

"""
    fgo_online(ins::INS, meas, flux::MagV, itp_mapS, x0_TL, P0, Qd, R;
               baro_tau       = 3600.0,
               acc_tau        = 3600.0,
               gyro_tau       = 3600.0,
               fogm_tau       = 600.0,
               date           = get_years(2020,185),
               core::Bool     = false,
               terms          = [:permanent,:induced,:eddy,:bias],
               Bt_scale       = 50000,
               robust::Symbol = :none,
               robust_c       = 0,
               n_iter         = 5,
               tol            = 1e-4,
               silent         = true)

Factor graph optimization (FGO) with batch estimation of Tolles-Lawson
coefficients (aeromagnetic compensation states).

**Arguments:**
- `ins`:      `INS` inertial navigation system struct
- `meas`:     scalar magnetometer measurement [nT]
- `flux`:     `MagV` vector magnetometer measurement struct
- `itp_mapS`: scalar map interpolation function (`f(lat,lon)` or `f(lat,lon,alt)`)
- `x0_TL`:    initial Tolles-Lawson coefficient states
- `P0`:       initial covariance matrix
- `Qd`:       discrete time process/system noise matrix
- `R`:        measurement (white) noise variance
- `baro_tau`: (optional) barometer time constant [s]
- `acc_tau`:  (optional) accelerometer time constant [s]
- `gyro_tau`: (optional) gyroscope time constant [s]
- `fogm_tau`: (optional) FOGM catch-all time constant [s]
- `date`:     (optional) measurement date (decimal year) for IGRF [yr]
- `core`:     (optional) if true, include core magnetic field in measurement
- `terms`:    (optional) Tolles-Lawson terms to use {`:permanent`,`:induced`,`:eddy`,`:bias`}
- `Bt_scale`: (optional) scaling factor for induced & eddy current terms [nT]
- `robust`:   (optional) robust measurement kernel {`:none`,`:huber`,`:cauchy`}
- `robust_c`: (optional) robust kernel tuning constant, `0` for default (`1.345` Huber, `2.385` Cauchy)
- `n_iter`:   (optional) maximum number of Gauss–Newton (relinearization/IRLS) iterations
- `tol`:      (optional) convergence tolerance on the RMS smoothed state change between iterations
- `silent`:   (optional) if true, no print outs

**Returns:**
- `filt_res`: `FILTres` filter (smoother) results struct
"""
function fgo_online(ins::INS, meas, flux::MagV, itp_mapS, x0_TL, P0, Qd, R;
                    baro_tau       = 3600.0,
                    acc_tau       = 3600.0,
                    gyro_tau       = 3600.0,
                    fogm_tau       = 600.0,
                    date           = get_years(2020,185),
                    core::Bool     = false,
                    terms          = [:permanent,:induced,:eddy,:bias],
                    Bt_scale       = 50000,
                    robust::Symbol = :none,
                    robust_c       = 0,
                    n_iter         = 5,
                    tol            = 1e-4,
                    silent         = true)
    fgo_online(ins.lat,ins.lon,ins.alt,ins.vn,ins.ve,ins.vd,ins.fn,ins.fe,ins.fd,
               ins.Cnb,meas,flux.x,flux.y,flux.z,ins.dt,itp_mapS,x0_TL,P0,Qd,R;
               baro_tau = baro_tau,
               acc_tau  = acc_tau,
               gyro_tau = gyro_tau,
               fogm_tau = fogm_tau,
               date     = date,
               core     = core,
               terms    = terms,
               Bt_scale = Bt_scale,
               robust   = robust,
               robust_c = robust_c,
               n_iter   = n_iter,
               tol      = tol,
               silent   = silent)
end # function fgo_online
