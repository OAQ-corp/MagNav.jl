% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_ind(xyz::XYZ, lines, df_line::DataFrame; splits        = (1),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_ind__ovl4(xyz, lines, df_line, varargin)
    out = [];
                 splits        = (1),
% TODO(Julia->MATLAB): l_window::Int = -1)

% TODO(Julia->MATLAB): assert sum(splits) ≈ 1 "sum of splits = $(sum(splits)) ≠ 1"
% TODO(Julia->MATLAB): assert length(splits) <= 3 "number of splits = $(length(splits)) > 3"

    ind = falses(xyz.traj.N)
% TODO(Julia->MATLAB): for line in lines
% TODO(Julia->MATLAB): if line in df_line.line
            ind = ind .| get_ind(xyz,line,df_line;l_window=l_window)
        end
end
