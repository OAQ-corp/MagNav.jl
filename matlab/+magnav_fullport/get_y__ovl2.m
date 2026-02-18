% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_y(lines, df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame; y_type::Symbol    = :d, use_mag::Symbol   = :mag_1_uc, use_mag_c::Symbol = :mag_1_c, sub_diurnal::Bool = false, sub_igrf::Bool    = false, l_window::Int     = -1, silent::Bool      = true)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_y__ovl2(lines, df_line, df_flight, df_map, varargin)
    out = [];
% TODO(Julia->MATLAB): df_map::DataFrame;
% TODO(Julia->MATLAB): y_type::Symbol    = :d,
% TODO(Julia->MATLAB): use_mag::Symbol   = :mag_1_uc,
% TODO(Julia->MATLAB): use_mag_c::Symbol = :mag_1_c,
% TODO(Julia->MATLAB): sub_diurnal::Bool = false,
% TODO(Julia->MATLAB): sub_igrf::Bool    = false,
% TODO(Julia->MATLAB): l_window::Int     = -1,
% TODO(Julia->MATLAB): silent::Bool      = true)

% TODO(Julia->MATLAB): % check if lines are in df_line, remove if not
% TODO(Julia->MATLAB): for l in lines
% TODO(Julia->MATLAB): if !(l in df_line.line)
% TODO(Julia->MATLAB): silent || @info("line $l is not in df_line, skipping")
            lines = lines(lines.~=l)
        end
end
