% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_2_test(A::Matrix, x::Matrix, y, data_norms::Tuple, model::Chain; model_type::Symbol = :m2a, TL_coef::Vector    = zeros(Float32,18),
% Mechanical conversion draft: review before production use.
function [y_hat, err] = nn_comp_2_test__ovl2(A, x, y, data_norms, model, varargin)
                        model_type::Symbol = :m2a,
                        TL_coef::Vector    = zeros(Float32,18),
                        l_segs::Vector     = [length(y)],
                        silent::Bool       = false)

    % convert to Float32 for consistency with nn_comp_2_train
    y = Float32.(y)

    % get results
    y_hat = nn_comp_2_fwd(A,x,data_norms,model;
                          model_type = model_type,
                          TL_coef    = TL_coef)
    err   = err_segs(y_hat,y,l_segs;silent=silent_debug)
    silent || @info("test  error: $(round(std(err),digits=2)) nT")

end % function nn_comp_2_test
end
