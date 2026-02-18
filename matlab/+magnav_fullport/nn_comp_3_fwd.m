% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_3_fwd(B_unit, B_vec, B_vec_dot, x_norm, y_bias, y_scale, model::Chain, TL_coef_p, TL_coef_i, TL_coef_e; model_type::Symbol = :m3s, y_type::Symbol     = :d, use_nn::Bool       = true, denorm::Bool       = true, testmode::Bool     = true)
% Mechanical conversion draft: review before production use.
function out = nn_comp_3_fwd(B_unit, B_vec, B_vec_dot, x_norm, y_bias, y_scale, model, TL_coef_p, TL_coef_i, TL_coef_e, varargin)
                       x_norm, y_bias, y_scale, model::Chain,
                       TL_coef_p, TL_coef_i, TL_coef_e;
                       model_type::Symbol = :m3s,
                       y_type::Symbol     = :d,
                       use_nn::Bool       = true,
                       denorm::Bool       = true,
                       testmode::Bool     = true)

    assert y_type in [:a,:b,:c,:d] "unsupported y_type = $y_type for nn_comp_3"

    % set to test mode in case model uses batchnorm or dropout
    m = model
    testmode && Flux.testmode!(m)

    % get results
    TL_aircraft  = get_TL_aircraft_vec(B_vec,B_vec_dot,TL_coef_p,TL_coef_i,TL_coef_e)
    vec_aircraft = TL_aircraft

    if (model_type in [:m3v,:m3vc]) & use_nn % vector NN correction to TL
        vec_aircraft += m(x_norm) .* y_scale;
    end
end
