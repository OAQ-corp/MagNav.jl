% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_Axy(lines, df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame, features_setup::Vector{Symbol}   = [:mag_1_uc,:TL_A_flux_a]; features_no_norm::Vector{Symbol} = Symbol[], y_type::Symbol     = :d, use_mag::Symbol    = :mag_1_uc, use_mag_c::Symbol  = :mag_1_c, use_vec::Symbol    = :flux_a, terms              = [:permanent,:induced,:eddy], terms_A            = [:permanent,:induced,:eddy,:bias], sub_diurnal::Bool  = false, sub_igrf::Bool     = false, bpf_mag::Bool      = false, reorient_vec::Bool = false, l_window::Int      = -1, mod_TL::Bool       = false, map_TL::Bool       = false, return_B::Bool     = false, silent::Bool       = true)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_Axy(lines, df_line, df_flight, df_map, features_setup, f__TL_A_flux_a_, varargin)
    out = [];
% TODO(Julia->MATLAB): df_flight::DataFrame, df_map::DataFrame,
% TODO(Julia->MATLAB): features_setup::Vector{Symbol}   = [:mag_1_uc,:TL_A_flux_a];
% TODO(Julia->MATLAB): features_no_norm::Vector{Symbol} = Symbol[],
% TODO(Julia->MATLAB): y_type::Symbol     = :d,
% TODO(Julia->MATLAB): use_mag::Symbol    = :mag_1_uc,
% TODO(Julia->MATLAB): use_mag_c::Symbol  = :mag_1_c,
% TODO(Julia->MATLAB): use_vec::Symbol    = :flux_a,
% TODO(Julia->MATLAB): terms              = [:permanent,:induced,:eddy],
% TODO(Julia->MATLAB): terms_A            = [:permanent,:induced,:eddy,:bias],
% TODO(Julia->MATLAB): sub_diurnal::Bool  = false,
% TODO(Julia->MATLAB): sub_igrf::Bool     = false,
% TODO(Julia->MATLAB): bpf_mag::Bool      = false,
% TODO(Julia->MATLAB): reorient_vec::Bool = false,
% TODO(Julia->MATLAB): l_window::Int      = -1,
% TODO(Julia->MATLAB): mod_TL::Bool       = false,
% TODO(Julia->MATLAB): map_TL::Bool       = false,
% TODO(Julia->MATLAB): return_B::Bool     = false,
% TODO(Julia->MATLAB): silent::Bool       = true)

    lines = [lines;] % ensure vector

% TODO(Julia->MATLAB): % check if lines are in df_line, remove if not
% TODO(Julia->MATLAB): for l in lines
% TODO(Julia->MATLAB): if !(l in df_line.line)
% TODO(Julia->MATLAB): silent || @info("line $l is not in df_line, skipping")
            lines = lines(lines.~=l)
        end
end
