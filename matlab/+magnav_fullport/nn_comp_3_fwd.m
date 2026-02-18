% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_3_fwd(B_unit, B_vec, B_vec_dot, x_norm, y_bias, y_scale, model::Chain, TL_coef_p, TL_coef_i, TL_coef_e; model_type::Symbol = :m3s, y_type::Symbol     = :d, use_nn::Bool       = true, denorm::Bool       = true, testmode::Bool     = true)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = nn_comp_3_fwd(B_unit, B_vec, B_vec_dot, x_norm, y_bias, y_scale, model, TL_coef_p, TL_coef_i, TL_coef_e, varargin)
    out = [];
% TODO(Julia->MATLAB): x_norm, y_bias, y_scale, model::Chain,
                       TL_coef_p, TL_coef_i, TL_coef_e;
% TODO(Julia->MATLAB): model_type::Symbol = :m3s,
% TODO(Julia->MATLAB): y_type::Symbol     = :d,
% TODO(Julia->MATLAB): use_nn::Bool       = true,
% TODO(Julia->MATLAB): denorm::Bool       = true,
% TODO(Julia->MATLAB): testmode::Bool     = true)

% TODO(Julia->MATLAB): assert y_type in [:a,:b,:c,:d] "unsupported y_type = $y_type for nn_comp_3"

% TODO(Julia->MATLAB): % set to test mode in case model uses batchnorm or dropout
    m = model
% TODO(Julia->MATLAB): testmode && Flux.testmode!(m)

    % get results
    TL_aircraft  = get_TL_aircraft_vec(B_vec,B_vec_dot,TL_coef_p,TL_coef_i,TL_coef_e)
    vec_aircraft = TL_aircraft

% TODO(Julia->MATLAB): if (model_type in [:m3v,:m3vc]) & use_nn % vector NN correction to TL
% TODO(Julia->MATLAB): vec_aircraft += m(x_norm) .* y_scale;
    end
end
