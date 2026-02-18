% Auto-generated from src/mpf.jl
% Original Julia signature: function mpf(ins::INS, meas, itp_mapS; P0         = create_P0(),
% Mechanical conversion draft: review before production use.
function out = mpf__ovl2(ins, meas, itp_mapS, varargin)
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
    mpf(ins.lat,ins.lon,ins.alt,ins.vn,ins.ve,ins.vd,ins.fn,ins.fe,ins.fd,
        ins.Cnb,meas,ins.dt,itp_mapS;
        P0       = P0,
        Qd       = Qd,
        R        = R,
        num_part = num_part,
        thresh   = thresh,
        baro_tau = baro_tau,
        acc_tau  = acc_tau,
        gyro_tau = gyro_tau,
        fogm_tau = fogm_tau,
        date     = date,
        core     = core)
end % function mpf
end
