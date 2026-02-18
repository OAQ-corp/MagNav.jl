% Auto-generated from src/compensation.jl
% Original Julia signature: function comp_test(comp_params::CompParams, xyz::XYZ, ind, mapS::Union{MapS,MapSd,MapS3D} = mapS_null; temp_params::TempParams        = TempParams(),
% Mechanical conversion draft: review before production use.
function out = comp_test(comp_params, xyz, ind, mapS, MapSd, MapS3D_, varargin)
                   mapS::Union{MapS,MapSd,MapS3D} = mapS_null;
                   temp_params::TempParams        = TempParams(),
                   silent::Bool                   = false)

    seed!(2) % for reproducibility
    t0 = time()

    % unpack parameters
    if comp_params isa NNCompParams
        @unpack version, features_setup, features_no_norm, model_type, y_type,
        use_mag, use_vec, data_norms, model, terms, terms_A, sub_diurnal,
        sub_igrf, bpf_mag, reorient_vec, norm_type_A, norm_type_x, norm_type_y,
        TL_coef, η_adam, epoch_adam, epoch_lbfgs, hidden, activation, loss,
        batchsize, frac_train, α_sgl, λ_sgl, k_pca,
        drop_fi, drop_fi_bson, drop_fi_csv, perm_fi, perm_fi_csv = comp_params
    elseif comp_params isa LinCompParams
        @unpack version, features_setup, features_no_norm, model_type, y_type,
        use_mag, use_vec, data_norms, model, terms, terms_A, sub_diurnal,
        sub_igrf, bpf_mag, reorient_vec, norm_type_A, norm_type_x, norm_type_y,
        k_plsr, λ_TL = comp_params
        drop_fi = false
        perm_fi = false
    end
end
