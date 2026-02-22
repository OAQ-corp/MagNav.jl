% Auto-generated from src/compensation.jl
% Original Julia signature: function linear_fwd(x_norm, y_bias, y_scale, model::Tuple)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function y_hat = linear_fwd(x_norm, y_bias, y_scale, model)
    y_hat = [];

    % unpack linear model weights
    (coef,bias) = model

    % get results
    y_hat_norm = x_norm*coef .+ bias
    y_hat      = denorm_sets(y_bias,y_scale,y_hat_norm)

% return (y_hat)
end % function linear_fwd
end
