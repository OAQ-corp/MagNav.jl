% Auto-generated from src/compensation.jl
% Original Julia signature: function linear_fwd(x_norm, y_bias, y_scale, model::Tuple)
% Mechanical conversion draft: review before production use.
function y_hat = linear_fwd(x_norm, y_bias, y_scale, model)

    % unpack linear model weights
    (coef,bias) = model

    % get results
    y_hat_norm = x_norm*coef .+ bias
    y_hat      = denorm_sets(y_bias,y_scale,y_hat_norm)

end % function linear_fwd
end
