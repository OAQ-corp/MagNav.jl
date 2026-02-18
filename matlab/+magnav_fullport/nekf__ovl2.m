% Auto-generated from src/nekf.jl
% Original Julia signature: function nekf(ins::INS, meas, itp_mapS, x_nn::Matrix = meas[:,:], m            = Dense(1 => 1);
% Mechanical conversion draft: review before production use.
function out = nekf__ovl2(ins, meas, itp_mapS, x_nn, f___, m)
              x_nn::Matrix = meas[:,:],
              m            = Dense(1 => 1);
              P0           = create_P0(),
              Qd           = create_Qd(),
              R            = 1.0,
              baro_tau     = 3600.0,
              acc_tau      = 3600.0,
              gyro_tau     = 3600.0,
              fogm_tau     = 600.0,
              date         = get_years(2020,185),
              core::Bool   = false)
    nekf(ins.lat,ins.lon,ins.alt,ins.vn,ins.ve,ins.vd,
         ins.fn,ins.fe,ins.fd,ins.Cnb,meas,ins.dt,itp_mapS,x_nn,m;
         P0       = P0,
         Qd       = Qd,
         R        = R,
         baro_tau = baro_tau,
         acc_tau  = acc_tau,
         gyro_tau = gyro_tau,
         fogm_tau = fogm_tau,
         date     = date,
         core     = core)
end % function nekf
end
