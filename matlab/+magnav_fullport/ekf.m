% Auto-generated from src/ekf_&_crlb.jl
% Original Julia signature: function ekf(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS; P0         = create_P0(),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = ekf(lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb, meas, dt, itp_mapS, varargin)
    out = [];
             P0         = create_P0(),
             Qd         = create_Qd(),
             R          = 1.0,
             baro_tau   = 3600.0,
             acc_tau    = 3600.0,
             gyro_tau   = 3600.0,
             fogm_tau   = 600.0,
             date       = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool = false,
             der_mapS   = [],
             map_alt    = 0)

    N     = length(lat)
    nx    = size(P0,1)
    ny    = size(meas,2)
    x_out = zeros(eltype(P0),nx,N)
    P_out = zeros(eltype(P0),nx,nx,N)
    r_out = zeros(eltype(P0),ny,N)
    x     = zeros(eltype(P0),nx) % state estimate
    P     = P0 % covariance matrix

    if length(R) == 2
        adapt = true
        (R_min,R_max) = R
        R = mean(R)
    else
        adapt = false
    end
end
