% Auto-generated from src/ekf_online.jl
% Original Julia signature: function ekf_online(ins::INS, meas, flux::MagV, itp_mapS, x0_TL, P0, Qd, R; baro_tau   = 3600.0, acc_tau    = 3600.0, gyro_tau   = 3600.0, fogm_tau   = 600.0, date       = get_years(2020,185),
% Mechanical conversion draft: review before production use.
function out = ekf_online__ovl2(ins, meas, flux, itp_mapS, x0_TL, P0, Qd, R, varargin)
                    baro_tau   = 3600.0,
                    acc_tau    = 3600.0,
                    gyro_tau   = 3600.0,
                    fogm_tau   = 600.0,
                    date       = get_years(2020,185),
                    core::Bool = false,
                    terms      = [:permanent,:induced,:eddy,:bias],
                    Bt_scale   = 50000)
    ekf_online(ins.lat,ins.lon,ins.alt,ins.vn,ins.ve,ins.vd,ins.fn,ins.fe,ins.fd,
               ins.Cnb,meas,flux.x,flux.y,flux.z,ins.dt,itp_mapS,x0_TL,P0,Qd,R;
               baro_tau = baro_tau,
               acc_tau  = acc_tau,
               gyro_tau = gyro_tau,
               fogm_tau = fogm_tau,
               date     = date,
               core     = core,
               terms    = terms,
               Bt_scale = Bt_scale)
end % function ekf_online
end
