% Auto-generated from src/eval_filt.jl
% Original Julia signature: function run_filt(traj::Traj, ins::INS, meas, itp_mapS, filt_type::Vector{Symbol}; P0         = create_P0(),
% Mechanical conversion draft: review before production use.
function out = run_filt__ovl2(traj, ins, meas, itp_mapS, filt_type, varargin)
                  filt_type::Vector{Symbol};
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
                  core::Bool = false,
                  map_alt    = 0,
                  x_nn       = nothing,
                  m          = nothing,
                  y_norms    = nothing,
                  terms      = [:permanent,:induced,:eddy,:bias],
                  flux::MagV = MagV([0.0],[0.0],[0.0],[0.0]),
                  x0_TL      = ones(eltype(P0),19))

    for i in eachindex(filt_type)
        @info("running $(filt_type[i]) filter")
        run_filt(traj,ins,meas,itp_mapS,filt_type[i];
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
