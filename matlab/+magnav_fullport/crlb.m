% Auto-generated from src/ekf_&_crlb.jl
% Original Julia signature: function crlb(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, dt, itp_mapS; P0         = create_P0(),
% Mechanical conversion draft: review before production use.
function out = crlb(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, dt, itp_mapS, varargin)
              P0         = create_P0(),
              Qd         = create_Qd(),
              R          = 1.0,
              baro_tau   = 3600.0,
              acc_tau    = 3600.0,
              gyro_tau   = 3600.0,
              fogm_tau   = 600.0,
              date       = get_years(2020,185),
              core::Bool = false)

    N     = length(lat)
    nx    = size(P0,1)
    P_out = zeros(eltype(P0),nx,nx,N)
    x     = zeros(eltype(P0),nx) % state estimate
    P     = P0 % covariance matrix

    length(R) == 2 && (R = mean(R))
    map_cache = itp_mapS isa Map_Cache ? itp_mapS : nothing

    for t = 1:N
        % custom itp_mapS from map cache, if available
        if map_cache isa Map_Cache
            itp_mapS = get_cached_map(map_cache,lat[t],lon[t],alt[t];silent=true)
        end
end
