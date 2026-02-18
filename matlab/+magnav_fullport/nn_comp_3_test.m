% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_3_test(B_unit, B_vec, B_vec_dot, x_norm, y, y_bias, y_scale, model::Chain, TL_coef_p, TL_coef_i, TL_coef_e; model_type::Symbol = :m3s, y_type::Symbol      = :d, l_segs::Vector     = [length(y)],
% Mechanical conversion draft: review before production use.
function [y_hat, err] = nn_comp_3_test(B_unit, B_vec, B_vec_dot, x_norm, y, y_bias, y_scale, model, TL_coef_p, TL_coef_i, TL_coef_e, varargin)
                        x_norm, y, y_bias, y_scale, model::Chain,
                        TL_coef_p, TL_coef_i, TL_coef_e;
                        model_type::Symbol = :m3s,
                        y_type::Symbol      = :d,
                        l_segs::Vector     = [length(y)],
                        use_nn::Bool       = true,
                        denorm::Bool       = true,
                        testmode::Bool     = true,
                        silent::Bool       = false)

    assert y_type in [:a,:b,:c,:d] "unsupported y_type = $y_type for nn_comp_3"

    % get results
    y_hat = nn_comp_3_fwd(B_unit,B_vec,B_vec_dot,
                          x_norm,y_bias,y_scale,model,
                          TL_coef_p,TL_coef_i,TL_coef_e;
                          model_type = model_type,
                          y_type     = y_type,
                          use_nn     = use_nn,
                          denorm     = denorm,
                          testmode   = testmode)
    err   = err_segs(y_hat,y,l_segs;silent=silent_debug)
    silent || @info("test  error: $(round(std(err),digits=2)) nT")

end % function nn_comp_3_test
end
