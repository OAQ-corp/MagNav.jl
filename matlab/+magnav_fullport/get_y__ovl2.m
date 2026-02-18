% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_y(lines, df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame; y_type::Symbol    = :d, use_mag::Symbol   = :mag_1_uc, use_mag_c::Symbol = :mag_1_c, sub_diurnal::Bool = false, sub_igrf::Bool    = false, l_window::Int     = -1, silent::Bool      = true)
% Mechanical conversion draft: review before production use.
function out = get_y__ovl2(lines, df_line, df_flight, df_map, varargin)
               df_map::DataFrame;
               y_type::Symbol    = :d,
               use_mag::Symbol   = :mag_1_uc,
               use_mag_c::Symbol = :mag_1_c,
               sub_diurnal::Bool = false,
               sub_igrf::Bool    = false,
               l_window::Int     = -1,
               silent::Bool      = true)

    % check if lines are in df_line, remove if not
    for l in lines
        if !(l in df_line.line)
            silent || @info("line $l is not in df_line, skipping")
            lines = lines[lines.~=l]
        end
end
