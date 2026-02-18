% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_2_fwd(A_norm::AbstractMatrix, x_norm::AbstractMatrix, y_bias, y_scale, model::Chain; model_type::Symbol   = :m2a, TL_coef_norm::Vector = zeros(Float32,18),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = nn_comp_2_fwd(A_norm, x_norm, y_bias, y_scale, model, varargin)
    out = [];
% TODO(Julia->MATLAB): model_type::Symbol   = :m2a,
% TODO(Julia->MATLAB): TL_coef_norm::Vector = zeros(Float32,18),
% TODO(Julia->MATLAB): denorm::Bool         = true,
% TODO(Julia->MATLAB): testmode::Bool       = true)

% TODO(Julia->MATLAB): % set to test mode in case model uses batchnorm or dropout
    m = model
% TODO(Julia->MATLAB): testmode && Flux.testmode!(m)

    % get results
% TODO(Julia->MATLAB): if model_type in [:m2a]
        y_hat = vec(sum(A_norm.*m(x_norm), dims=1))
% TODO(Julia->MATLAB): elseif model_type in [:m2b,:m2c]
        y_hat = vec(m(x_norm)) + A_norm'*TL_coef_norm
% TODO(Julia->MATLAB): elseif model_type in [:m2d]
        y_hat = vec(sum(A_norm.*(m(x_norm) .+ TL_coef_norm), dims=1))
    end
end
