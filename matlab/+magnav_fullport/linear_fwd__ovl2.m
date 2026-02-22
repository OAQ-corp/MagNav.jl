% Auto-generated from src/compensation.jl
% Original Julia signature: function linear_fwd(x, data_norms::Tuple, model::Tuple)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function y_hat = linear_fwd__ovl2(x, data_norms, model)
    y_hat = [];

    % unpack data normalizations
    (x_bias,x_scale,y_bias,y_scale) = data_norms
    x_norm = (x .- x_bias) ./ x_scale

    % get results
    y_hat = linear_fwd(x_norm,y_bias,y_scale,model)

% return (y_hat)
end % function linear_fwd
end
