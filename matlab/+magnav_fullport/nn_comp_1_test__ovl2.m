% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_1_test(x::Matrix, y, data_norms::Tuple, model::Chain; l_segs::Vector = [length(y)],
% Mechanical conversion draft: review before production use.
function [y_hat, err] = nn_comp_1_test__ovl2(x, y, data_norms, model, varargin)
                        l_segs::Vector = [length(y)],
                        silent::Bool   = false)

    % convert to Float32 for consistency with nn_comp_1_train
    y = Float32.(y)

    % get results
    y_hat = nn_comp_1_fwd(x,data_norms,model)
    err   = err_segs(y_hat,y,l_segs;silent=silent_debug)
    silent || @info("test  error: $(round(std(err),digits=2)) nT")

end % function nn_comp_1_test
end
