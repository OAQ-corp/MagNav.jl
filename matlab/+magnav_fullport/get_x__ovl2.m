% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_x(xyz_vec::Vector, ind_vec::Vector, features_setup::Vector{Symbol}   = [:mag_1_uc,:TL_A_flux_a]; features_no_norm::Vector{Symbol} = Symbol[], terms             = [:permanent,:induced,:eddy], sub_diurnal::Bool = false, sub_igrf::Bool    = false, bpf_mag::Bool     = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_x__ovl2(xyz_vec, ind_vec, features_setup, f__TL_A_flux_a_, varargin)
    out = [];
% TODO(Julia->MATLAB): features_setup::Vector{Symbol}   = [:mag_1_uc,:TL_A_flux_a];
% TODO(Julia->MATLAB): features_no_norm::Vector{Symbol} = Symbol[],
% TODO(Julia->MATLAB): terms             = [:permanent,:induced,:eddy],
% TODO(Julia->MATLAB): sub_diurnal::Bool = false,
% TODO(Julia->MATLAB): sub_igrf::Bool    = false,
% TODO(Julia->MATLAB): bpf_mag::Bool     = false)

    (x,no_norm,features,l_segs) = get_x(xyz_vec(1),ind_vec(1),features_setup;
                                        features_no_norm = features_no_norm,
                                        terms            = terms,
                                        sub_diurnal      = sub_diurnal,
                                        sub_igrf         = sub_igrf,
                                        bpf_mag          = bpf_mag)

% TODO(Julia->MATLAB): for (xyz,ind) in zip(xyz_vec(2:end),ind_vec(2:end))
        (x_,_,_,l_segs_) = get_x(xyz,ind,features_setup;
                                 features_no_norm = features_no_norm,
                                 terms            = terms,
                                 sub_diurnal      = sub_diurnal,
                                 sub_igrf         = sub_igrf,
                                 bpf_mag          = bpf_mag)
        x = vcat(x,x_)
        l_segs = vcat(l_segs,l_segs_)
    end
end
