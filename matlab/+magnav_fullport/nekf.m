% Auto-generated from src/nekf.jl
% Original Julia signature: function nekf(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS, x_nn::Matrix = meas[:,:], m            = Dense(1 => 1);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = nekf(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS, x_nn, f___, m)
    out = [];
% TODO(Julia->MATLAB): x_nn::Matrix = meas(:,:),
% TODO(Julia->MATLAB): m            = Dense(1 => 1);
              P0           = create_P0(),
              Qd           = create_Qd(),
              R            = 1.0,
              baro_tau     = 3600.0,
              acc_tau      = 3600.0,
              gyro_tau     = 3600.0,
              fogm_tau     = 600.0,
              date         = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool   = false)

    N      = length(lat)
    nx     = size(P0,1)
    ny     = size(meas,2)
    x_out  = zeros(eltype(P0),nx,N)
    P_out  = zeros(eltype(P0),nx,nx,N)
    r_out  = zeros(eltype(P0),ny,N)
    R_nn   = m(x_nn') % pre-compute R correction

    x = zeros(eltype(P0),nx) % state estimate
    P = P0 % covariance matrix
    map_cache = itp_mapS isa Map_Cache ? itp_mapS : []

% TODO(Julia->MATLAB): for t = 1:N
        % custom itp_mapS from map cache, if available
        if map_cache isa Map_Cache
            itp_mapS = get_cached_map(map_cache,lat(t),lon(t),alt(t);silent=true)
        end
end
