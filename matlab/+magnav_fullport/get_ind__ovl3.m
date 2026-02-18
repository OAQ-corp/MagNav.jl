% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_ind(xyz::XYZ, line::Real, df_line::DataFrame; splits        = (1),
% Mechanical conversion draft: review before production use.
function out = get_ind__ovl3(xyz, line, df_line, varargin)
                 splits        = (1),
                 l_window::Int = -1)

    tt_lim = [df_line.t_start[df_line.line .== line][1],
              df_line.t_end[  df_line.line .== line][end]]
    fields = fieldnames(typeof(xyz))
    line_  = :line in fields ? xyz.line : one.(xyz.traj.tt[ind])
    inds   = get_ind(xyz.traj.tt,line_;
                     lines  = [line],
                     tt_lim = tt_lim,
                     splits = splits)

    if l_window > 0
        if (inds) isa Tuple
            for ind in inds
                N_trim = length(xyz.traj.lat[ind]) % l_window
                for _ = 1:N_trim
                    ind[findlast(ind.==1)] = 0
                end
end
