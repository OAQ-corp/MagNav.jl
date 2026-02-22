% Auto-generated from src/ekf_online_nn.jl
% Original Julia signature: function ekf_online_nn(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS, x_nn, m, y_norms, P0, Qd, R; baro_tau   = 3600.0, acc_tau    = 3600.0, gyro_tau   = 3600.0, fogm_tau   = 600.0, date       = get_years(2020,185),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = ekf_online_nn(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS, x_nn, m, y_norms, P0, Qd, R, varargin)
    out = [];
                       dt, itp_mapS, x_nn, m, y_norms, P0, Qd, R;
                       baro_tau   = 3600.0,
                       acc_tau    = 3600.0,
                       gyro_tau   = 3600.0,
                       fogm_tau   = 600.0,
                       date       = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool = false)

    (y_bias,y_scale) = y_norms

    N     = length(lat)
    nx    = size(P0,1)
    nx_nn = sum(length,Params(trainables(m)))
    ny    = size(meas,2)
    x_out = zeros(eltype(P0),nx,N)
    P_out = zeros(eltype(P0),nx,nx,N)
    r_out = zeros(eltype(P0),ny,N)
    x     = zeros(eltype(P0),nx) % state estimate
    P     = P0 % covariance matrix

    (w0_nn,re) = destructure(m)
% TODO(Julia->MATLAB): x(end-nx_nn:end-1) = w0_nn

    map_cache = itp_mapS isa Map_Cache ? itp_mapS : []

% TODO(Julia->MATLAB): for t = 1:N
        % custom itp_mapS from map cache, if available
        if map_cache isa Map_Cache
            itp_mapS = get_cached_map(map_cache,lat(t),lon(t),alt(t);silent=true)
        end
end
