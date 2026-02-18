% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_3_test(A, Bt, B_dot, x, y, data_norms::Tuple, model::Chain; model_type::Symbol = :m3s, y_type::Symbol     = :d, TL_coef::Vector    = zeros(Float32,18),
% Mechanical conversion draft: review before production use.
function [y_hat, err] = nn_comp_3_test__ovl2(A, Bt, B_dot, x, y, data_norms, model, varargin)
                        model_type::Symbol = :m3s,
                        y_type::Symbol     = :d,
                        TL_coef::Vector    = zeros(Float32,18),
                        terms_A            = [:permanent,:induced,:eddy],
                        l_segs::Vector     = [length(y)],
                        l_window::Int      = 5,
                        silent::Bool       = false)

    assert y_type in [:a,:b,:c,:d] "unsupported y_type = $y_type for nn_comp_3"

    % convert to Float32 for consistency with nn_comp_3_train
    y = Float32.(y)

    % get results
    y_hat = nn_comp_3_fwd(A,Bt,B_dot,x,data_norms,model;
                          model_type = model_type,
                          y_type     = y_type,
                          TL_coef    = TL_coef,
                          terms_A    = terms_A,
                          l_segs     = l_segs,
                          l_window   = l_window)
    err   = err_segs(y_hat,y,l_segs;silent=silent_debug)
    silent || @info("test  error: $(round(std(err),digits=2)) nT")

end % function nn_comp_3_test
end
