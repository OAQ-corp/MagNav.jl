% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_1_test(x::Matrix, y, data_norms::Tuple, model::Chain; l_segs::Vector = [length(y)],
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [y_hat, err] = nn_comp_1_test__ovl2(x, y, data_norms, model, varargin)
    y_hat = [];
% TODO(Julia->MATLAB): l_segs::Vector = [length(y)],
% TODO(Julia->MATLAB): silent::Bool   = false)

    % convert to Float32 for consistency with nn_comp_1_train
    y = Float32(y)

    % get results
    y_hat = nn_comp_1_fwd(x,data_norms,model)
    err   = err_segs(y_hat,y,l_segs;silent=silent_debug)
% TODO(Julia->MATLAB): silent || @info("test  error: $(round(std(err),digits=2)) nT")

% return (y_hat, err)
end % function nn_comp_1_test
end
