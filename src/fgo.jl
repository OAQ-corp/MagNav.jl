"""
    fgo(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS;
        P0         = create_P0(),
        Qd         = create_Qd(),
        R          = 1.0,
        baro_tau   = 3600.0,
        acc_tau    = 3600.0,
        gyro_tau   = 3600.0,
        fogm_tau   = 600.0,
        date       = get_years(2020,185),
        core::Bool = false,
        der_mapS   = nothing,
        map_alt    = 0,
        n_iter     = 5,
        tol        = 1e-4,
        silent     = true)

Factor graph optimization (FGO) for airborne magnetic anomaly navigation.

The navigation problem is posed as a factor graph whose variables are the
error states `x_t` (`t = 1,...,N`) of the Pinson error model (see
[`get_pinson`](@ref)) and whose factors are:

- a **prior factor** on `x_1`, with information `P0^-1`,
- **process (motion) factors** tying `x_{t+1}` to `Φ_t x_t`, with information
  `Qd^-1`, where `Φ_t` is the Pinson transition matrix (see [`get_Phi`](@ref)),
- **measurement factors** on the scalar magnetometer, with information `R^-1`,
  where the expected measurement `h(x_t)` and its Jacobian `H_t` come from the
  magnetic anomaly map (see [`get_h`](@ref) & [`get_H`](@ref)).

The maximum a posteriori (MAP) estimate is the minimizer of the negative
log-likelihood (the factor graph objective)

    J(x_1,...,x_N) = ‖x_1‖²_{P0^-1}
                   + Σ_t ‖x_{t+1} - Φ_t x_t‖²_{Qd^-1}
                   + Σ_t ‖meas_t - h(x_t)‖²_{R^-1} .

For this linear-Gaussian error model the factor graph is a chain, so the MAP
estimate is obtained exactly with an iterated fixed-interval (Rauch–Tung–Striebel)
smoother: a forward information/covariance pass followed by a backward pass, with
the (nonlinear) magnetic measurement relinearized about the smoothed trajectory
between outer iterations (Gauss–Newton on the factor graph). Unlike the causal
[`ekf`](@ref), every state estimate uses **all** measurements (past and future),
which typically reduces the navigation error, especially early in the flight.

**Arguments:**
- `lat`:      latitude  [rad]
- `lon`:      longitude [rad]
- `alt`:      altitude  [m]
- `vn`:       north velocity [m/s]
- `ve`:       east  velocity [m/s]
- `vd`:       down  velocity [m/s]
- `fn`:       north specific force [m/s^2]
- `fe`:       east  specific force [m/s^2]
- `fd`:       down  specific force [m/s^2]
- `Cnb`:      direction cosine matrix (body to navigation) [-]
- `meas`:     scalar magnetometer measurement [nT]
- `dt`:       measurement time step [s]
- `itp_mapS`: scalar map interpolation function (`f(lat,lon)` or `f(lat,lon,alt)`)
- `P0`:       (optional) initial covariance matrix
- `Qd`:       (optional) discrete time process/system noise matrix
- `R`:        (optional) measurement (white) noise variance
- `baro_tau`: (optional) barometer time constant [s]
- `acc_tau`:  (optional) accelerometer time constant [s]
- `gyro_tau`: (optional) gyroscope time constant [s]
- `fogm_tau`: (optional) FOGM catch-all time constant [s]
- `date`:     (optional) measurement date (decimal year) for IGRF [yr]
- `core`:     (optional) if true, include core magnetic field in measurement
- `der_mapS`: (optional) scalar map vertical derivative map interpolation function (`f(lat,lon)` or (`f(lat,lon,alt)`)
- `map_alt`:  (optional) map altitude [m]
- `n_iter`:   (optional) maximum number of Gauss–Newton (relinearization) iterations
- `tol`:      (optional) convergence tolerance on the RMS smoothed state change between iterations
- `silent`:   (optional) if true, no print outs

**Returns:**
- `filt_res`: `FILTres` filter (smoother) results struct
"""
function fgo(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS;
             P0         = create_P0(),
             Qd         = create_Qd(),
             R          = 1.0,
             baro_tau   = 3600.0,
             acc_tau    = 3600.0,
             gyro_tau   = 3600.0,
             fogm_tau   = 600.0,
             date       = get_years(2020,185),
             core::Bool = false,
             der_mapS   = nothing,
             map_alt    = 0,
             n_iter     = 5,
             tol        = 1e-4,
             silent     = true)

    N  = length(lat)
    nx = size(P0,1)
    ny = size(meas,2)

    length(R) == 2 && (R = mean(R)) # adaptive R not supported, use mean

    map_cache = itp_mapS isa Map_Cache ? itp_mapS : nothing

    # per-time-step storage for the forward filter pass
    x_pred = zeros(eltype(P0),nx,N)   # a priori  state    (before update)
    P_pred = zeros(eltype(P0),nx,nx,N) # a priori  covariance
    x_upd  = zeros(eltype(P0),nx,N)   # a posteriori state (after  update)
    P_upd  = zeros(eltype(P0),nx,nx,N) # a posteriori covariance
    Phi_a  = zeros(eltype(P0),nx,nx,N) # Pinson transition matrices (t -> t+1)

    # smoothed states (also used as the relinearization reference `x_bar`)
    x_smooth = zeros(eltype(P0),nx,N)
    P_smooth = zeros(eltype(P0),nx,nx,N)
    r_out    = zeros(eltype(P0),ny,N)

    for iter = 1:n_iter

        x_bar = copy(x_smooth) # relinearize measurement about previous smoother pass

        # -------------------- forward pass (information/covariance) -----------
        x = zeros(eltype(P0),nx) # a priori state estimate at t = 1
        P = P0                   # a priori covariance    at t = 1

        for t = 1:N
            # custom itp_mapS from map cache, if available
            if map_cache isa Map_Cache
                itp_mapS = get_cached_map(map_cache,lat[t],lon[t],alt[t];silent=true)
            end

            x_pred[:,t]   = x
            P_pred[:,:,t] = P

            xb = x_bar[:,t] # relinearization reference for this time step

            # expected measurement & Jacobian, linearized about the reference
            if (map_alt > 0) & !(der_mapS isa Nothing)
                h_ref = get_h(itp_mapS,der_mapS,xb,lat[t],lon[t],alt[t],map_alt;
                              date=date,core=core)
            else
                h_ref = get_h(itp_mapS,xb,lat[t],lon[t],alt[t];date=date,core=core)
            end
            H = repeat(get_H(itp_mapS,xb,lat[t],lon[t],alt[t];
                             date=date,core=core)',ny,1) # ny x nx

            # residual of the (relinearized) measurement about a priori state x
            resid = meas[t,:] .- (h_ref .+ H*(x .- xb))

            S = H*P*H' .+ R    # measurement residual covariance
            K = (P*H') / S     # Kalman gain

            x = x + K*resid    # measurement update
            P = (I - K*H) * P
            P = (P + P') / 2   # keep symmetric

            x_upd[:,t]   = x
            P_upd[:,:,t] = P

            # propagate (predict) to t+1
            if t < N
                Phi = get_Phi(nx,lat[t],vn[t],ve[t],vd[t],fn[t],fe[t],fd[t],
                              Cnb[:,:,t],baro_tau,acc_tau,gyro_tau,fogm_tau,dt)
                Phi_a[:,:,t] = Phi
                x = Phi*x
                P = Phi*P*Phi' + Qd
                P = (P + P') / 2
            end
        end

        # -------------------- backward pass (RTS smoother) --------------------
        x_smooth[:,N]   = x_upd[:,N]
        P_smooth[:,:,N] = P_upd[:,:,N]

        for t = (N-1):-1:1
            Phi = Phi_a[:,:,t]
            # smoother gain C = P_upd Phi' P_pred(t+1)^-1
            C = (P_upd[:,:,t] * Phi') / P_pred[:,:,t+1]
            x_smooth[:,t]   = x_upd[:,t]   + C*(x_smooth[:,t+1]   - x_pred[:,t+1])
            P_smooth[:,:,t] = P_upd[:,:,t] + C*(P_smooth[:,:,t+1] - P_pred[:,:,t+1])*C'
            P_smooth[:,:,t] = (P_smooth[:,:,t] + P_smooth[:,:,t]') / 2
        end

        # convergence check on the RMS change of the smoothed states
        dx = sqrt(mean(abs2, x_smooth .- x_bar))
        if !silent
            J = fgo_cost(x_smooth,Phi_a,meas,lat,lon,alt,itp_mapS,der_mapS,map_alt,
                         P0,Qd,R,date,core,map_cache)
            @info("fgo iter $iter: Δx_rms = $(round(dx,sigdigits=3)), J = $(round(J,sigdigits=6))")
        end
        (iter > 1) && (dx < tol) && break
    end

    # post-fit (nonlinear) measurement residuals at the smoothed estimate
    for t = 1:N
        if map_cache isa Map_Cache
            itp_mapS = get_cached_map(map_cache,lat[t],lon[t],alt[t];silent=true)
        end
        if (map_alt > 0) & !(der_mapS isa Nothing)
            r_out[:,t] = meas[t,:] .- get_h(itp_mapS,der_mapS,x_smooth[:,t],
                                            lat[t],lon[t],alt[t],map_alt;date=date,core=core)
        else
            r_out[:,t] = meas[t,:] .- get_h(itp_mapS,x_smooth[:,t],
                                            lat[t],lon[t],alt[t];date=date,core=core)
        end
    end

    return FILTres(x_smooth, P_smooth, r_out, true)
end # function fgo

"""
    fgo(ins::INS, meas, itp_mapS;
        P0         = create_P0(),
        Qd         = create_Qd(),
        R          = 1.0,
        baro_tau   = 3600.0,
        acc_tau    = 3600.0,
        gyro_tau   = 3600.0,
        fogm_tau   = 600.0,
        date       = get_years(2020,185),
        core::Bool = false,
        der_mapS   = map_itp(zeros(2,2),[-pi,pi],[-pi/2,pi/2]),
        map_alt    = 0,
        n_iter     = 5,
        tol        = 1e-4,
        silent     = true)

Factor graph optimization (FGO) for airborne magnetic anomaly navigation.

**Arguments:**
- `ins`:      `INS` inertial navigation system struct
- `meas`:     scalar magnetometer measurement [nT]
- `itp_mapS`: scalar map interpolation function (`f(lat,lon)` or `f(lat,lon,alt)`)
- `P0`:       (optional) initial covariance matrix
- `Qd`:       (optional) discrete time process/system noise matrix
- `R`:        (optional) measurement (white) noise variance
- `baro_tau`: (optional) barometer time constant [s]
- `acc_tau`:  (optional) accelerometer time constant [s]
- `gyro_tau`: (optional) gyroscope time constant [s]
- `fogm_tau`: (optional) FOGM catch-all time constant [s]
- `date`:     (optional) measurement date (decimal year) for IGRF [yr]
- `core`:     (optional) if true, include core magnetic field in measurement
- `der_mapS`: (optional) scalar map vertical derivative map interpolation function (`f(lat,lon)` or (`f(lat,lon,alt)`)
- `map_alt`:  (optional) map altitude [m]
- `n_iter`:   (optional) maximum number of Gauss–Newton (relinearization) iterations
- `tol`:      (optional) convergence tolerance on the RMS smoothed state change between iterations
- `silent`:   (optional) if true, no print outs

**Returns:**
- `filt_res`: `FILTres` filter (smoother) results struct
"""
function fgo(ins::INS, meas, itp_mapS;
             P0         = create_P0(),
             Qd         = create_Qd(),
             R          = 1.0,
             baro_tau   = 3600.0,
             acc_tau    = 3600.0,
             gyro_tau   = 3600.0,
             fogm_tau   = 600.0,
             date       = get_years(2020,185),
             core::Bool = false,
             der_mapS   = map_itp(zeros(2,2),[-pi,pi],[-pi/2,pi/2]),
             map_alt    = 0,
             n_iter     = 5,
             tol        = 1e-4,
             silent     = true)
    fgo(ins.lat,ins.lon,ins.alt,ins.vn,ins.ve,ins.vd,ins.fn,ins.fe,ins.fd,
        ins.Cnb,meas,ins.dt,itp_mapS;
        P0       = P0,
        Qd       = Qd,
        R        = R,
        baro_tau = baro_tau,
        acc_tau  = acc_tau,
        gyro_tau = gyro_tau,
        fogm_tau = fogm_tau,
        date     = date,
        core     = core,
        der_mapS = der_mapS,
        map_alt  = map_alt,
        n_iter   = n_iter,
        tol      = tol,
        silent   = silent)
end # function fgo

"""
    fgo_cost(x, Phi_a, meas, lat, lon, alt, itp_mapS, der_mapS, map_alt,
             P0, Qd, R, date, core, map_cache)

Internal helper function to evaluate the factor graph objective (negative
log-likelihood, up to a constant) at the states `x`:

    J = ‖x_1‖²_{P0^-1}
      + Σ_t ‖x_{t+1} - Φ_t x_t‖²_{Qd^-1}
      + Σ_t ‖meas_t - h(x_t)‖²_{R^-1} .

Used only for reporting optimization convergence.

**Returns:**
- `J`: factor graph objective (scalar)
"""
function fgo_cost(x, Phi_a, meas, lat, lon, alt, itp_mapS, der_mapS, map_alt,
                  P0, Qd, R, date, core, map_cache)

    N = size(x,2)

    # prior factor on x_1
    J = dot(x[:,1], P0 \ x[:,1])

    # process (motion) factors
    for t = 1:(N-1)
        d = x[:,t+1] .- Phi_a[:,:,t]*x[:,t]
        J += dot(d, Qd \ d)
    end

    # measurement factors
    for t = 1:N
        itp = map_cache isa Map_Cache ?
              get_cached_map(map_cache,lat[t],lon[t],alt[t];silent=true) : itp_mapS
        if (map_alt > 0) & !(der_mapS isa Nothing)
            h = get_h(itp,der_mapS,x[:,t],lat[t],lon[t],alt[t],map_alt;date=date,core=core)
        else
            h = get_h(itp,x[:,t],lat[t],lon[t],alt[t];date=date,core=core)
        end
        resid = meas[t,:] .- h
        J += dot(resid, resid) / mean(R)
    end

    return (J)
end # function fgo_cost
