% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_2_fwd(A_norm::AbstractMatrix, x_norm::AbstractMatrix, y_bias, y_scale, model::Chain; model_type::Symbol   = :m2a, TL_coef_norm::Vector = zeros(Float32,18),
% Mechanical conversion draft: review before production use.
function out = nn_comp_2_fwd(A_norm, x_norm, y_bias, y_scale, model, varargin)
                       model_type::Symbol   = :m2a,
                       TL_coef_norm::Vector = zeros(Float32,18),
                       denorm::Bool         = true,
                       testmode::Bool       = true)

    % set to test mode in case model uses batchnorm or dropout
    m = model
    testmode && Flux.testmode!(m)

    % get results
    if model_type in [:m2a]
        y_hat = vec(sum(A_norm.*m(x_norm), dims=1))
    elseif model_type in [:m2b,:m2c]
        y_hat = vec(m(x_norm)) + A_norm'*TL_coef_norm
    elseif model_type in [:m2d]
        y_hat = vec(sum(A_norm.*(m(x_norm) .+ TL_coef_norm), dims=1))
    end
end
