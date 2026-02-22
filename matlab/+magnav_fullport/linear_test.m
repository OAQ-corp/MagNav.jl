% Auto-generated from src/compensation.jl
% Original Julia signature: function linear_test(x_norm, y, y_bias, y_scale, model::Tuple; l_segs::Vector = [length(y)],
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [y_hat, err] = linear_test(x_norm, y, y_bias, y_scale, model, varargin)
    y_hat = [];
% TODO(Julia->MATLAB): l_segs::Vector = [length(y)],
% TODO(Julia->MATLAB): silent::Bool   = false)

    % get results
    y_hat = linear_fwd(x_norm,y_bias,y_scale,model)
    err   = err_segs(y_hat,y,l_segs;silent=silent_debug)
% TODO(Julia->MATLAB): silent || @info("test  error: $(round(std(err),digits=2)) nT")

% return (y_hat, err)
end % function linear_test
end
