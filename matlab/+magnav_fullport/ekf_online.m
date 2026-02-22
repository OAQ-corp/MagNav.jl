% Auto-generated from src/ekf_online.jl
% Original Julia signature: function ekf_online(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, Bx, By, Bz, dt, itp_mapS, x0_TL, P0, Qd, R; baro_tau   = 3600.0, acc_tau    = 3600.0, gyro_tau   = 3600.0, fogm_tau   = 600.0, date       = get_years(2020,185),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = ekf_online(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, Bx, By, Bz, dt, itp_mapS, x0_TL, P0, Qd, R, varargin)
    out = [];
                    Bx, By, Bz, dt, itp_mapS, x0_TL, P0, Qd, R;
                    baro_tau   = 3600.0,
                    acc_tau    = 3600.0,
                    gyro_tau   = 3600.0,
                    fogm_tau   = 600.0,
                    date       = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool = false,
% TODO(Julia->MATLAB): terms      = [:permanent,:induced,:eddy,:bias],
                    Bt_scale   = 50000)

    N      = length(lat)
    ny     = size(meas,2)
    nx     = size(P0,1)
    nx_TL  = length(x0_TL)
    nx_vec = nx - 18 - nx_TL
    x_out  = zeros(eltype(P0),nx,N)
    P_out  = zeros(eltype(P0),nx,nx,N)
    r_out  = zeros(eltype(P0),ny,N)
    x      = zeros(eltype(P0),nx) % state estimate
    P      = P0        % covariance matrix
    A      = create_TL_A(Bx,By,Bz;
                         % Bt       = meas(:,1),
                         terms    = terms,
                         Bt_scale = Bt_scale)

    % function f(Bx,By,Bz,meas,terms,Bt_scale,x_TL)
    %     create_TL_A(Bx,By,Bz;
    %                 Bt       = meas,
    %                 terms    = terms,
% TODO(Julia->MATLAB): %                 Bt_scale = Bt_scale)[2,:]'*x_TL
    % end % function f

% TODO(Julia->MATLAB): x(end-nx_vec-nx_TL:end-nx_vec-1) = x0_TL

    vec_states = nx_vec > 0 ? true : false

    map_cache = itp_mapS isa Map_Cache ? itp_mapS : []

% TODO(Julia->MATLAB): for t = 1:N
        % custom itp_mapS from map cache, if available
        if map_cache isa Map_Cache
            itp_mapS = get_cached_map(map_cache,lat(t),lon(t),alt(t);silent=true)
        end
end
