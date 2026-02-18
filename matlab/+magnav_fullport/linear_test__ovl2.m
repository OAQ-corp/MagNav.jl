% Auto-generated from src/compensation.jl
% Original Julia signature: function linear_test(x, y, data_norms::Tuple, model::Tuple; l_segs::Vector = [length(y)],
% Mechanical conversion draft: review before production use.
function [y_hat, err] = linear_test__ovl2(x, y, data_norms, model, varargin)
                     l_segs::Vector = [length(y)],
                     silent::Bool   = false)

    % get results
    y_hat = linear_fwd(x,data_norms,model)
    err   = err_segs(y_hat,y,l_segs;silent=silent_debug)
    silent || @info("test  error: $(round(std(err),digits=2)) nT")

end % function linear_test
end
