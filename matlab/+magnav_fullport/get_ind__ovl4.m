% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_ind(xyz::XYZ, lines, df_line::DataFrame; splits        = (1),
% Mechanical conversion draft: review before production use.
function out = get_ind__ovl4(xyz, lines, df_line, varargin)
                 splits        = (1),
                 l_window::Int = -1)

    assert sum(splits) ≈ 1 "sum of splits = $(sum(splits)) ≠ 1"
    assert length(splits) <= 3 "number of splits = $(length(splits)) > 3"

    ind = falses(xyz.traj.N)
    for line in lines
        if line in df_line.line
            ind .= ind .| get_ind(xyz,line,df_line;l_window=l_window)
        end
end
