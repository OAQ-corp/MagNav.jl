% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_1_fwd(x_norm::AbstractMatrix, y_bias, y_scale, model::Chain; denorm::Bool   = true, testmode::Bool = true)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function y_hat = nn_comp_1_fwd(x_norm, y_bias, y_scale, model, varargin)
    y_hat = [];
% TODO(Julia->MATLAB): denorm::Bool   = true,
% TODO(Julia->MATLAB): testmode::Bool = true)

% TODO(Julia->MATLAB): % set to test mode in case model uses batchnorm or dropout
    m = model
% TODO(Julia->MATLAB): testmode && Flux.testmode!(m)

    % get results
    y_hat = vec(m(x_norm))

    denorm && (y_hat = denorm_sets(y_bias,y_scale,y_hat))

% return (y_hat)
end % function nn_comp_1_fwd
end
