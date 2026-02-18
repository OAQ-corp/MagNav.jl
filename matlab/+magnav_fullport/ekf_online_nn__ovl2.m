% Auto-generated from src/ekf_online_nn.jl
% Original Julia signature: function ekf_online_nn(ins::INS, meas, itp_mapS, x_nn, m, y_norms, P0, Qd, R; baro_tau   = 3600.0, acc_tau    = 3600.0, gyro_tau   = 3600.0, fogm_tau   = 600.0, date       = get_years(2020,185),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = ekf_online_nn__ovl2(ins, meas, itp_mapS, x_nn, m, y_norms, P0, Qd, R, varargin)
    out = [];
                       baro_tau   = 3600.0,
                       acc_tau    = 3600.0,
                       gyro_tau   = 3600.0,
                       fogm_tau   = 600.0,
                       date       = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool = false)
    ekf_online_nn(ins.lat,ins.lon,ins.alt,ins.vn,ins.ve,ins.vd,
                  ins.fn,ins.fe,ins.fd,ins.Cnb,meas,
                  ins.dt,itp_mapS,x_nn,m,y_norms,P0,Qd,R;
                  baro_tau = baro_tau,
                  acc_tau  = acc_tau,
                  gyro_tau = gyro_tau,
                  fogm_tau = fogm_tau,
                  date     = date,
                  core     = core)
end % function ekf_online_nn
end
