% Auto-generated from src/mpf.jl
% Original Julia signature: function mpf(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS; P0         = create_P0(),
% Mechanical conversion draft: review before production use.
function out = mpf(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS, varargin)
             P0         = create_P0(),
             Qd         = create_Qd(),
             R          = 1.0,
             num_part   = 1000,
             thresh     = 0.8,
             baro_tau   = 3600.0,
             acc_tau    = 3600.0,
             gyro_tau   = 3600.0,
             fogm_tau   = 600.0,
             date       = get_years(2020,185),
             core::Bool = false)

    N      = length(lat)  % number of samples (instances)
    np     = num_part     % number of particles
    nx     = size(P0,1)   % total state dimension
    nxn    = 2            % non-linear state dimension (inherent to this model)
    nxl    = nx - nxn     % linear state dimension
    ny     = size(meas,2) % measurement dimension
    T2     = eltype(P0)   % floating precision type

    H      = [zeros(T2,1,nxl-1) 1] % linear measurement Jacobian
    x_out  = zeros(T2,nx,N)        % filtered states, i.e., E[x(t) | y_1,..,y_t]
    Pn_out = zeros(T2,nxn,nxn,N)   % non-linear portion of covariance matrix
    Pl_out = zeros(T2,nxl,nxl,N)   % linear portion of covariance matrix
    resid  = zeros(T2,ny,N)        % measurement residuals

    % initialize non-linear states
    xn = chol(P0[1:nxn,1:nxn])'*randn(T2,nxn,np) % 2 x np

    % initialize conditionally linear Gaussian states
    xl = zeros(T2,nxl,np) % 16 x np

    % initialize linear portion of covariance matrix
    Pl = P0[nxn+1:end,nxn+1:end] % 16 x 16

    % initialize particle weights
    q = ones(T2,np)/np % np

    map_cache = itp_mapS isa Map_Cache ? itp_mapS : nothing

    for t = 1:N
        % custom itp_mapS from map cache, if available
        if map_cache isa Map_Cache
            itp_mapS = get_cached_map(map_cache,lat[t],lon[t],alt[t];silent=true)
        end
end
