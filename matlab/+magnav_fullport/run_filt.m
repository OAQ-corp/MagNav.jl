% Auto-generated from src/eval_filt.jl
% Original Julia signature: function run_filt(traj::Traj, ins::INS, meas, itp_mapS, filt_type::Symbol = :ekf; P0             = create_P0(),
% Mechanical conversion draft: review before production use.
function out = run_filt(traj, ins, meas, itp_mapS, filt_type, varargin)
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
                  core::Bool     = false,
                  map_alt        = 0,
                  x_nn           = nothing,
                  m              = nothing,
                  y_norms        = nothing,
                  terms          = [:permanent,:induced,:eddy,:bias],
                  flux::MagV     = MagV([0.0],[0.0],[0.0],[0.0]),
                  x0_TL          = ones(eltype(P0),19),
                  extract::Bool  = true,
                  run_crlb::Bool = true)

    if filt_type == :ekf
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
    elseif filt_type == :ekf_online
        filt_res = ekf_online(ins,meas,flux,itp_mapS,x0_TL,P0,Qd,R;
                              baro_tau = baro_tau,
                              acc_tau  = acc_tau,
                              gyro_tau = gyro_tau,
                              fogm_tau = fogm_tau,
                              date     = date,
                              core     = core,
                              terms    = terms);
    elseif filt_type == :ekf_online_nn
        filt_res = ekf_online_nn(ins,meas,itp_mapS,x_nn,m,y_norms,P0,Qd,R;
                                 baro_tau = baro_tau,
                                 acc_tau  = acc_tau,
                                 gyro_tau = gyro_tau,
                                 fogm_tau = fogm_tau,
                                 date     = date,
                                 core     = core);
    elseif filt_type == :mpf
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
    elseif filt_type == :nekf
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
        error("filt_type $filt_type not defined")
    end
end
