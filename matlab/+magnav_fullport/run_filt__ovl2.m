% Auto-generated from src/eval_filt.jl
% Original Julia signature: function run_filt(traj::Traj, ins::INS, meas, itp_mapS, filt_type::Vector{Symbol}; P0         = create_P0(),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = run_filt__ovl2(traj, ins, meas, itp_mapS, filt_type, varargin)
    out = [];
% TODO(Julia->MATLAB): filt_type::Vector{Symbol};
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
% TODO(Julia->MATLAB): core::Bool = false,
                  map_alt    = 0,
                  x_nn       = [],
                  m          = [],
                  y_norms    = [],
% TODO(Julia->MATLAB): terms      = [:permanent,:induced,:eddy,:bias],
% TODO(Julia->MATLAB): flux::MagV = MagV([0.0],[0.0],[0.0],[0.0]),
                  x0_TL      = ones(eltype(P0),19))

% TODO(Julia->MATLAB): for i in eachindex(filt_type)
% TODO(Julia->MATLAB): @info("running $(filt_type(i)) filter")
        run_filt(traj,ins,meas,itp_mapS,filt_type(i);
                 P0          = P0,
                 Qd          = Qd,
                 R           = R,
                 num_part    = num_part,
                 thresh      = thresh,
                 baro_tau    = baro_tau,
                 acc_tau     = acc_tau,
                 gyro_tau    = gyro_tau,
                 fogm_tau    = fogm_tau,
                 date        = date,
                 core        = core,
                 map_alt     = map_alt,
                 x_nn        = x_nn,
                 m           = m,
                 y_norms     = y_norms,
                 terms       = terms,
                 flux        = flux,
                 x0_TL       = x0_TL,
                 extract     = true,
                 run_crlb    = false)
    end
end
