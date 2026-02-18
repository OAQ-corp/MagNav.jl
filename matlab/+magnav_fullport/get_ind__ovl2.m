% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_ind(xyz::XYZ; ind    = trues(xyz.traj.N),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_ind__ovl2(xyz, varargin)
    out = [];
                 ind    = trues(xyz.traj.N),
                 lines  = (),
                 tt_lim = (),
                 splits = (1))
    fields = fieldnames(typeof(xyz))
% TODO(Julia->MATLAB): line_  = :line in fields ? xyz.line : one(xyz.traj.tt(ind))
    get_ind(xyz.traj.tt,line_;
            ind    = ind,
            lines  = lines,
            tt_lim = tt_lim,
            splits = splits)
end % function get_ind
end
