"""
    fgo_sensor(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS;
               P0             = create_P0(),
               Qd             = create_Qd(),
               R              = 1.0,
               baro_tau       = 3600.0,
               acc_tau        = 3600.0,
               gyro_tau       = 3600.0,
               fogm_tau       = 600.0,
               date           = get_years(2020,185),
               core::Bool     = false,
               der_mapS       = nothing,
               map_alt        = 0,
               n_harm::Int    = 0,
               cal_bias::Bool = false,
               sigma_head     = 50.0,
               sigma_bias     = 50.0,
               q_head         = 1e-4,
               q_bias         = 1e-4,
               robust::Symbol = :none,
               robust_c       = 0,
               n_iter         = 6,
               tol            = 1e-4,
               silent         = true)

Factor graph optimization (FGO) for airborne magnetic anomaly navigation with
explicit **scalar magnetometer sensor-error factors**. Extends [`fgo`](@ref) by
appending sensor-error states to the Pinson error states and modeling their
contribution to the scalar measurement.

Two physically-motivated, heading/attitude-dependent error sources can be
enabled (individually or together), both entering the scalar measurement
**linearly** so the factor graph stays a well-conditioned Gauss–Newton problem:

- **Heading error** (`n_harm > 0`): optically-pumped / quantum scalar
  magnetometers exhibit a reading error that depends on the sensor–field
  geometry. It is modeled as a truncated Fourier series in the aircraft
  heading (yaw) `ψ`,

      Δ_head(t) = Σ_{k=1}^{n_harm} [ a_k cos(k ψ_t) + b_k sin(k ψ_t) ] ,

  with the `2·n_harm` coefficients `{a_k,b_k}` estimated as factor graph
  variables (near-constant, with a slow random walk).

- **Fluxgate hard-iron bias** (`cal_bias = true`): a body-fixed vector bias
  `m` on the vector magnetometer projects onto the scalar total-field reading,
  to first order,

      Δ_bias(t) = m · û_body(t) ,   û_body(t) = Cnb(t)' û_field(t) ,

  where `û_field` is the unit core-field direction (IGRF). The `3` bias
  components are estimated as factor graph variables. Because `û_body` rotates
  with aircraft attitude/heading, the bias is observable and decorrelates from
  the position-locked map anomaly.

Unlike a low-dimensional grid/point-mass estimator (which carries only
position), the continuous factor graph estimates these sensor-error states
**jointly with navigation**, recovering a sensor calibration as a by-product.

The estimated states are ordered `[Pinson (nx0) ; heading (2·n_harm) ; bias (3)]`;
the trailing sensor states are returned in the `FILTres.x` matrix.

**Arguments:** (in addition to those of [`fgo`](@ref))
- `n_harm`:     number of heading-error harmonics (`0` disables the heading factor)
- `cal_bias`:   if true, include the `3`-state fluxgate hard-iron bias factor
- `sigma_head`: heading coefficient prior std dev [nT]
- `sigma_bias`: hard-iron bias prior std dev [nT]
- `q_head`:     heading coefficient random-walk driving variance [nT^2]
- `q_bias`:     hard-iron bias random-walk driving variance [nT^2]
- `robust`:     robust measurement kernel {`:none`,`:huber`,`:cauchy`}
- `robust_c`:   robust kernel tuning constant, `0` for default
- `n_iter`:     maximum number of Gauss–Newton (relinearization/IRLS) iterations

**Returns:**
- `filt_res`: `FILTres` filter (smoother) results struct (augmented state)
"""
function fgo_sensor(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS;
                    P0             = create_P0(),
                    Qd             = create_Qd(),
                    R              = 1.0,
                    baro_tau       = 3600.0,
                    acc_tau        = 3600.0,
                    gyro_tau       = 3600.0,
                    fogm_tau       = 600.0,
                    date           = get_years(2020,185),
                    core::Bool     = false,
                    der_mapS       = nothing,
                    map_alt        = 0,
                    n_harm::Int    = 0,
                    cal_bias::Bool = false,
                    sigma_head     = 50.0,
                    sigma_bias     = 50.0,
                    q_head         = 1e-4,
                    q_bias         = 1e-4,
                    robust::Symbol = :none,
                    robust_c       = 0,
                    n_iter         = 6,
                    tol            = 1e-4,
                    silent         = true)

    @assert robust in (:none,:huber,:cauchy) "robust kernel $robust not defined"

    N   = length(lat)
    nx0 = size(P0,1)             # base Pinson state dimension
    nh  = 2*n_harm               # heading coefficient states
    nb  = cal_bias ? 3 : 0       # hard-iron bias states
    nx  = nx0 + nh + nb          # augmented state dimension
    ny  = size(meas,2)

    length(R) == 2 && (R = mean(R))
    Rs = mean(R)
    robust_c == 0 && (robust_c = robust == :cauchy ? 2.385 : 1.345)

    map_cache = itp_mapS isa Map_Cache ? itp_mapS : nothing
    itps = map_cache isa Map_Cache ?
           [get_cached_map(map_cache,lat[t],lon[t],alt[t];silent=true) for t = 1:N] :
           fill(itp_mapS,N)

    # heading (yaw) sequence [rad]
    (_,_,psi) = dcm2euler(Cnb,:body2nav)
    psi = vec([psi;])

    # sensor-error measurement bases (each column is the factor's Jacobian row)
    Bh = zeros(eltype(P0),nh,N) # heading harmonics basis
    for k = 1:n_harm
        Bh[2k-1,:] = cos.(k .* psi)
        Bh[2k  ,:] = sin.(k .* psi)
    end
    Bb = zeros(eltype(P0),nb,N)  # hard-iron bias basis (unit field direction, body)
    if cal_bias
        for t = 1:N
            v = igrf(date,alt[t],lat[t],lon[t],Val(:geodetic))
            u = v ./ norm(v)               # unit core-field direction (nav frame)
            Bb[:,t] = Cnb[:,:,t]' * u       # rotate into body frame
        end
    end

    # augmented prior covariance & process noise
    P0_a = zeros(eltype(P0),nx,nx)
    P0_a[1:nx0,1:nx0] = P0
    Qd_a = zeros(eltype(P0),nx,nx)
    Qd_a[1:nx0,1:nx0] = Qd
    for i = 1:nh
        P0_a[nx0+i,nx0+i] = sigma_head^2
        Qd_a[nx0+i,nx0+i] = q_head
    end
    for i = 1:nb
        P0_a[nx0+nh+i,nx0+nh+i] = sigma_bias^2
        Qd_a[nx0+nh+i,nx0+nh+i] = q_bias
    end

    # augmented transition matrices: Pinson block + identity (constant) sensor block
    Phi_a = zeros(eltype(P0),nx,nx,N-1)
    for t = 1:(N-1)
        Phi_a[1:nx0,1:nx0,t] = get_Phi(nx0,lat[t],vn[t],ve[t],vd[t],fn[t],fe[t],
                                       fd[t],Cnb[:,:,t],baro_tau,acc_tau,gyro_tau,
                                       fogm_tau,dt)
        for i = 1:(nh+nb)
            Phi_a[nx0+i,nx0+i,t] = 1
        end
    end

    # expected measurement & Jacobian at reference states x_bar [nx x N]
    function meas_model(x_bar)
        h_bar = zeros(eltype(P0),N)
        H_bar = zeros(eltype(P0),nx,N)
        for t = 1:N
            x18 = x_bar[1:nx0,t]
            if (map_alt > 0) & !(der_mapS isa Nothing)
                h_map = get_h(itps[t],der_mapS,x18,lat[t],lon[t],alt[t],map_alt;
                              date=date,core=core)[1]
            else
                h_map = get_h(itps[t],x18,lat[t],lon[t],alt[t];date=date,core=core)[1]
            end
            H_map = get_H(itps[t],x18,lat[t],lon[t],alt[t];date=date,core=core)

            h_head = nh > 0 ? dot(Bh[:,t],x_bar[nx0+1:nx0+nh,t])       : zero(eltype(P0))
            h_bias = nb > 0 ? dot(Bb[:,t],x_bar[nx0+nh+1:nx0+nh+nb,t]) : zero(eltype(P0))

            h_bar[t]   = h_map + h_head + h_bias
            H_bar[:,t] = vcat(H_map, Bh[:,t], Bb[:,t])
        end
        return (h_bar, H_bar)
    end

    x_smooth = zeros(eltype(P0),nx,N)
    P_smooth = zeros(eltype(P0),nx,nx,N)
    w        = ones(eltype(P0),N)

    for iter = 1:n_iter
        x_bar = copy(x_smooth)
        (h_bar,H_bar) = meas_model(x_bar)

        if (robust != :none) & (iter > 1)
            for t = 1:N
                e    = abs(mean(meas[t,:]) - h_bar[t]) / sqrt(Rs)
                w[t] = clamp(robust_weight(e,robust,robust_c),1e-6,1)
            end
        end

        (x_smooth,P_smooth) = fgo_rts_pass(x_bar,h_bar,H_bar,Phi_a,meas,
                                           P0_a,Qd_a,R,w,ny)

        dx = sqrt(mean(abs2, x_smooth .- x_bar))
        silent || @info("fgo_sensor iter $iter: Δx_rms = $(round(dx,sigdigits=3))")
        (iter > 1) && (dx < tol) && break
    end

    r_out = zeros(eltype(P0),ny,N)
    (h_fit,_) = meas_model(x_smooth)
    for t = 1:N
        r_out[:,t] = meas[t,:] .- h_fit[t]
    end

    return FILTres(x_smooth, P_smooth, r_out, true)
end # function fgo_sensor

"""
    fgo_sensor(ins::INS, meas, itp_mapS; kwargs...)

Factor graph optimization (FGO) with scalar magnetometer sensor-error factors.

**Arguments:**
- `ins`:      `INS` inertial navigation system struct
- `meas`:     scalar magnetometer measurement [nT]
- `itp_mapS`: scalar map interpolation function (`f(lat,lon)` or `f(lat,lon,alt)`)
- `kwargs`:   see the array method of [`fgo_sensor`](@ref)

**Returns:**
- `filt_res`: `FILTres` filter (smoother) results struct (augmented state)
"""
function fgo_sensor(ins::INS, meas, itp_mapS; kwargs...)
    fgo_sensor(ins.lat,ins.lon,ins.alt,ins.vn,ins.ve,ins.vd,ins.fn,ins.fe,ins.fd,
               ins.Cnb,meas,ins.dt,itp_mapS; kwargs...)
end # function fgo_sensor
