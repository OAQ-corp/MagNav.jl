% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_Axy(lines, df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame, features_setup::Vector{Symbol}   = [:mag_1_uc,:TL_A_flux_a]; features_no_norm::Vector{Symbol} = Symbol[], y_type::Symbol     = :d, use_mag::Symbol    = :mag_1_uc, use_mag_c::Symbol  = :mag_1_c, use_vec::Symbol    = :flux_a, terms              = [:permanent,:induced,:eddy], terms_A            = [:permanent,:induced,:eddy,:bias], sub_diurnal::Bool  = false, sub_igrf::Bool     = false, bpf_mag::Bool      = false, reorient_vec::Bool = false, l_window::Int      = -1, mod_TL::Bool       = false, map_TL::Bool       = false, return_B::Bool     = false, silent::Bool       = true)
% Mechanical conversion draft: review before production use.
function out = get_Axy(lines, df_line, df_flight, df_map, features_setup, f__TL_A_flux_a_, varargin)
                 df_flight::DataFrame, df_map::DataFrame,
                 features_setup::Vector{Symbol}   = [:mag_1_uc,:TL_A_flux_a];
                 features_no_norm::Vector{Symbol} = Symbol[],
                 y_type::Symbol     = :d,
                 use_mag::Symbol    = :mag_1_uc,
                 use_mag_c::Symbol  = :mag_1_c,
                 use_vec::Symbol    = :flux_a,
                 terms              = [:permanent,:induced,:eddy],
                 terms_A            = [:permanent,:induced,:eddy,:bias],
                 sub_diurnal::Bool  = false,
                 sub_igrf::Bool     = false,
                 bpf_mag::Bool      = false,
                 reorient_vec::Bool = false,
                 l_window::Int      = -1,
                 mod_TL::Bool       = false,
                 map_TL::Bool       = false,
                 return_B::Bool     = false,
                 silent::Bool       = true)

    lines = [lines;] % ensure vector

    % check if lines are in df_line, remove if not
    for l in lines
        if !(l in df_line.line)
            silent || @info("line $l is not in df_line, skipping")
            lines = lines[lines.~=l]
        end
end
