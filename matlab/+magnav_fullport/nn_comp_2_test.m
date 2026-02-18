% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_2_test(A_norm::AbstractMatrix, x_norm::AbstractMatrix, y, y_bias, y_scale, model::Chain; model_type::Symbol   = :m2a, TL_coef_norm::Vector = zeros(Float32,18),
% Mechanical conversion draft: review before production use.
function [y_hat, err] = nn_comp_2_test(A_norm, x_norm, y, y_bias, y_scale, model, varargin)
                        model_type::Symbol   = :m2a,
                        TL_coef_norm::Vector = zeros(Float32,18),
                        l_segs::Vector       = [length(y)],
                        silent::Bool         = false)

    % get results
    y_hat = nn_comp_2_fwd(A_norm,x_norm,y_bias,y_scale,model;
                          model_type   = model_type,
                          TL_coef_norm = TL_coef_norm)
    err   = err_segs(y_hat,y,l_segs;silent=silent_debug)
    silent || @info("test  error: $(round(std(err),digits=2)) nT")

end % function nn_comp_2_test
end
