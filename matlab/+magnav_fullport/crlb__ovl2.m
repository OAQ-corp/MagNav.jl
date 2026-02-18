% Auto-generated from src/ekf_&_crlb.jl
% Original Julia signature: function crlb(traj::Traj, itp_mapS; P0         = create_P0(),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = crlb__ovl2(traj, itp_mapS, varargin)
    out = [];
              P0         = create_P0(),
              Qd         = create_Qd(),
              R          = 1.0,
              baro_tau   = 3600.0,
              acc_tau    = 3600.0,
              gyro_tau   = 3600.0,
              fogm_tau   = 600.0,
              date       = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool = false)
    crlb(traj.lat,traj.lon,traj.alt,traj.vn,traj.ve,traj.vd,
         traj.fn,traj.fe,traj.fd,traj.Cnb,traj.dt,itp_mapS;
         P0       = P0,
         Qd       = Qd,
         R        = R,
         baro_tau = baro_tau,
         acc_tau  = acc_tau,
         gyro_tau = gyro_tau,
         fogm_tau = fogm_tau,
         date     = date,
         core     = core)
end % function crlb
end
