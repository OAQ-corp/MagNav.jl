% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_x(lines, df_line::DataFrame, df_flight::DataFrame, features_setup::Vector{Symbol}   = [:mag_1_uc,:TL_A_flux_a]; features_no_norm::Vector{Symbol} = Symbol[], terms              = [:permanent,:induced,:eddy], sub_diurnal::Bool  = false, sub_igrf::Bool     = false, bpf_mag::Bool      = false, reorient_vec::Bool = false, l_window::Int      = -1, silent::Bool       = true)
% Mechanical conversion draft: review before production use.
function out = get_x__ovl3(lines, df_line, df_flight, features_setup, f__TL_A_flux_a_, varargin)
               features_setup::Vector{Symbol}   = [:mag_1_uc,:TL_A_flux_a];
               features_no_norm::Vector{Symbol} = Symbol[],
               terms              = [:permanent,:induced,:eddy],
               sub_diurnal::Bool  = false,
               sub_igrf::Bool     = false,
               bpf_mag::Bool      = false,
               reorient_vec::Bool = false,
               l_window::Int      = -1,
               silent::Bool       = true)

    lines = [lines;] % ensure vector

    % check if lines are in df_line, remove if not
    for l in lines
        if !(l in df_line.line)
            silent || @info("line $l is not in df_line, skipping")
            lines = lines[lines.~=l]
        end
end
