% Auto-generated from src/ekf_&_crlb.jl
% Original Julia signature: function ekf(ins::INS, meas, itp_mapS; P0         = create_P0(),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = ekf__ovl2(ins, meas, itp_mapS, varargin)
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
             der_mapS   = map_itp(zeros(2,2),[-pi,pi],[-pi/2,pi/2]),
             map_alt    = 0)
    ekf(ins.lat,ins.lon,ins.alt,ins.vn,ins.ve,ins.vd,ins.fn,ins.fe,ins.fd,
        ins.Cnb,meas,ins.dt,itp_mapS;
        P0       = P0,
        Qd       = Qd,
        R        = R,
        baro_tau = baro_tau,
        acc_tau  = acc_tau,
        gyro_tau = gyro_tau,
        fogm_tau = fogm_tau,
        date     = date,
        core     = core,
        der_mapS = der_mapS,
        map_alt  = map_alt)
end % function ekf
end
