% Auto-generated from src/eval_filt.jl
% Original Julia signature: function run_filt(traj::Traj, ins::INS, meas, itp_mapS, filt_type::Symbol = :ekf; P0             = create_P0(),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = run_filt(traj, ins, meas, itp_mapS, filt_type, varargin)
    out = [];
                  P0             = create_P0(),
                  Qd             = create_Qd(),
                  R              = 1.0,
                  num_part       = 1000,
                  thresh         = 0.8,
                  baro_tau       = 3600.0,
                  acc_tau        = 3600.0,
                  gyro_tau       = 3600.0,
                  fogm_tau       = 600.0,
                  date           = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool     = false,
                  map_alt        = 0,
                  x_nn           = [],
                  m              = [],
                  y_norms        = [],
% TODO(Julia->MATLAB): terms          = [:permanent,:induced,:eddy,:bias],
% TODO(Julia->MATLAB): flux::MagV     = MagV([0.0],[0.0],[0.0],[0.0]),
                  x0_TL          = ones(eltype(P0),19),
% TODO(Julia->MATLAB): extract::Bool  = true,
% TODO(Julia->MATLAB): run_crlb::Bool = true)

% TODO(Julia->MATLAB): if filt_type == :ekf
        filt_res = ekf(ins,meas,itp_mapS;
                       P0       = P0,
                       Qd       = Qd,
                       R        = R,
                       baro_tau = baro_tau,
                       acc_tau  = acc_tau,
                       gyro_tau = gyro_tau,
                       fogm_tau = fogm_tau,
                       date     = date,
                       core     = core,
                       map_alt  = map_alt);
% TODO(Julia->MATLAB): elseif filt_type == :ekf_online
        filt_res = ekf_online(ins,meas,flux,itp_mapS,x0_TL,P0,Qd,R;
                              baro_tau = baro_tau,
                              acc_tau  = acc_tau,
                              gyro_tau = gyro_tau,
                              fogm_tau = fogm_tau,
                              date     = date,
                              core     = core,
                              terms    = terms);
% TODO(Julia->MATLAB): elseif filt_type == :ekf_online_nn
        filt_res = ekf_online_nn(ins,meas,itp_mapS,x_nn,m,y_norms,P0,Qd,R;
                                 baro_tau = baro_tau,
                                 acc_tau  = acc_tau,
                                 gyro_tau = gyro_tau,
                                 fogm_tau = fogm_tau,
                                 date     = date,
                                 core     = core);
% TODO(Julia->MATLAB): elseif filt_type == :mpf
        filt_res = mpf(ins,meas,itp_mapS;
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
                       core     = core);
% TODO(Julia->MATLAB): elseif filt_type == :nekf
        filt_res = nekf(ins,meas,itp_mapS,x_nn,m;
                        P0       = P0,
                        Qd       = Qd,
                        R        = R,
                        baro_tau = baro_tau,
                        acc_tau  = acc_tau,
                        gyro_tau = gyro_tau,
                        fogm_tau = fogm_tau,
                        date     = date,
                        core     = core);
    else
% TODO(Julia->MATLAB): error("filt_type $filt_type not defined")
    end
end
