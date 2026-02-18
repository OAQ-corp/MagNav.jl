% Auto-generated from src/compensation.jl
% Original Julia signature: function comp_m2bc_test(comp_params::NNCompParams, lines, df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame; silent::Bool = false)
% Mechanical conversion draft: review before production use.
function [y_nn, y_TL, y, y_hat, err, features] = comp_m2bc_test(comp_params, lines, df_line, df_flight, df_map, varargin)
                        df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame;
                        silent::Bool = false)

    seed!(2) % for reproducibility
    t0 = time()

    % unpack parameters
    @unpack version, features_setup, features_no_norm, model_type, y_type,
    use_mag, use_vec, data_norms, model, terms, terms_A, sub_diurnal,
    sub_igrf, bpf_mag, reorient_vec, norm_type_A, norm_type_x, norm_type_y,
    TL_coef, η_adam, epoch_adam, epoch_lbfgs, hidden, activation, loss,
    batchsize, frac_train, α_sgl, λ_sgl, k_pca,
    drop_fi, drop_fi_bson, drop_fi_csv, perm_fi, perm_fi_csv = comp_params

    % load data
    (A,x,y,_,features,l_segs) = get_Axy(lines,df_line,df_flight,df_map,
                                        features_setup;
                                        features_no_norm = features_no_norm,
                                        y_type           = y_type,
                                        use_mag          = use_mag,
                                        use_vec          = use_vec,
                                        terms            = terms,
                                        terms_A          = terms_A,
                                        sub_diurnal      = sub_diurnal,
                                        sub_igrf         = sub_igrf,
                                        bpf_mag          = bpf_mag,
                                        reorient_vec     = reorient_vec,
                                        return_B         = false,
                                        silent           = silent_debug)

    % convert to Float32 for consistency with nn_comp_2_train
    A       = Float32.(A)
    x       = Float32.(x)
    y       = Float32.(y)
    TL_coef = Float32.(TL_coef)

    % unpack data normalizations
    (A_bias,A_scale,v_scale,x_bias,x_scale,y_bias,y_scale) =
        unpack_data_norms(data_norms)
    A_norm = ( (A .- A_bias) ./ A_scale           )'
    x_norm = (((x .- x_bias) ./ x_scale) * v_scale)'

    TL_coef_norm = TL_coef ./ y_scale

    % set to test mode in case model uses batchnorm or dropout
    m = model
    Flux.testmode!(m)

    y_nn  = vec(m(x_norm))       .* y_scale
    y_TL  = A_norm'*TL_coef_norm .* y_scale

    (y_hat,err) = nn_comp_2_test(A_norm,x_norm,y,y_bias,y_scale,m;
                                 model_type   = model_type,
                                 TL_coef_norm = TL_coef_norm,
                                 l_segs       = l_segs,
                                 silent       = true)

    silent || @info("std    y_nn: $(round(std(y_nn),digits=2)) nT")
    silent || @info("std    y_TL: $(round(std(y_TL),digits=2)) nT")
    silent || @info("test  error: $(round(std(err ),digits=2)) nT")
    silent || print_time(time()-t0,1)

end % function comp_m2bc_test
end
