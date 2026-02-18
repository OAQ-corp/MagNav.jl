% Auto-generated from src/compensation.jl
% Original Julia signature: function comp_m3_test(comp_params::NNCompParams, lines, df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame; temp_params::TempParams = TempParams(),
% Mechanical conversion draft: review before production use.
function out = comp_m3_test(comp_params, lines, df_line, df_flight, df_map, varargin)
                      df_line::DataFrame, df_flight::DataFrame, df_map::DataFrame;
                      temp_params::TempParams = TempParams(),
                      silent::Bool            = false)

    seed!(2) % for reproducibility
    t0 = time()

    % unpack parameters
    @unpack version, features_setup, features_no_norm, model_type, y_type,
    use_mag, use_vec, data_norms, model, terms, terms_A, sub_diurnal,
    sub_igrf, bpf_mag, reorient_vec, norm_type_A, norm_type_x, norm_type_y,
    TL_coef, η_adam, epoch_adam, epoch_lbfgs, hidden, activation, loss,
    batchsize, frac_train, α_sgl, λ_sgl, k_pca,
    drop_fi, drop_fi_bson, drop_fi_csv, perm_fi, perm_fi_csv = comp_params

    @unpack σ_curriculum, l_window, window_type, tf_layer_type, tf_norm_type,
    dropout_prob, N_tf_head, tf_gain = temp_params

    assert y_type in [:a,:b,:c,:d] "unsupported y_type = $y_type for nn_comp_3"
    assert model_type in [:m3s,:m3v,:m3sc,:m3vc,:m3w,:m3tf] "unsupported model_type = $model_type for model 3 explainability"

    mod_TL = model_type == :mod_TL ? true : false
    map_TL = model_type == :map_TL ? true : false

    (A,Bt,B_dot,x,y,_,features,l_segs) = get_Axy(lines,df_line,df_flight,df_map,
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
                                                 mod_TL           = mod_TL,
                                                 map_TL           = map_TL,
                                                 return_B         = true,
                                                 silent           = silent_debug)

    % convert to Float32 for consistency with nn_comp_3_train
    A       = Float32.(A)
    Bt      = Float32.(Bt)    % magnitude of total field measurements
    B_dot   = Float32.(B_dot) % finite differences of total field vector
    x       = Float32.(x)
    y       = Float32.(y)
    TL_coef = Float32.(TL_coef)

    % assume all terms are stored, but they may be zero if not trained
    Bt_scale = 50000f0
    (TL_coef_p,TL_coef_i,TL_coef_e) = TL_vec2mat(TL_coef,terms_A;Bt_scale=Bt_scale)

    B_unit    = A[:,1:3]'     % normalized vector magnetometer reading
    B_vec     = B_unit .* Bt' % vector magnetometer to be used in TL
    B_vec_dot = B_dot'        % not exactly true, but internally consistent

    % unpack data normalizations
    (_,_,v_scale,x_bias,x_scale,y_bias,y_scale) = unpack_data_norms(data_norms)
    x_norm = (((x .- x_bias) ./ x_scale) * v_scale)'

    model_type in [:m3w,:m3tf] && (x_norm = get_temporal_data(x_norm,l_segs,l_window))

    % set to test mode in case model uses batchnorm or dropout
    m = model
    Flux.testmode!(m)

    % calculate TL vector field
    (TL_aircraft,TL_perm,TL_induced,TL_eddy) =
        get_TL_aircraft_vec(B_vec,B_vec_dot,TL_coef_p,TL_coef_i,TL_coef_e;
                            return_parts=true)

    % compute neural network correction
    if model_type in [:m3s,:m3sc,:m3w,:m3tf] % scalar-corrected
        y_nn = vec(m(x_norm)) .* y_scale % rescale to TL [N]
        y_nn = y_nn' .* B_unit % assume same direction [3xN]
    elseif model_type in [:m3v,:m3vc] % vector-corrected
        y_nn = m(x_norm) .* y_scale % rescale to TL [3xN]
    end
end
