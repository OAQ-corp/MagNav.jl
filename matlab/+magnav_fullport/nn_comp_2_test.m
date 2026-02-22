% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_2_test(A_norm::AbstractMatrix, x_norm::AbstractMatrix, y, y_bias, y_scale, model::Chain; model_type::Symbol   = :m2a, TL_coef_norm::Vector = zeros(Float32,18),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [y_hat, err] = nn_comp_2_test(A_norm, x_norm, y, y_bias, y_scale, model, varargin)
    y_hat = [];
% TODO(Julia->MATLAB): model_type::Symbol   = :m2a,
% TODO(Julia->MATLAB): TL_coef_norm::Vector = zeros(Float32,18),
% TODO(Julia->MATLAB): l_segs::Vector       = [length(y)],
% TODO(Julia->MATLAB): silent::Bool         = false)

    % get results
    y_hat = nn_comp_2_fwd(A_norm,x_norm,y_bias,y_scale,model;
                          model_type   = model_type,
                          TL_coef_norm = TL_coef_norm)
    err   = err_segs(y_hat,y,l_segs;silent=silent_debug)
% TODO(Julia->MATLAB): silent || @info("test  error: $(round(std(err),digits=2)) nT")

% return (y_hat, err)
end % function nn_comp_2_test
end
