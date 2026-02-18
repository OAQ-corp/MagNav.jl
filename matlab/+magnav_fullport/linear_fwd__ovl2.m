% Auto-generated from src/compensation.jl
% Original Julia signature: function linear_fwd(x, data_norms::Tuple, model::Tuple)
% Mechanical conversion draft: review before production use.
function y_hat = linear_fwd__ovl2(x, data_norms, model)

    % unpack data normalizations
    (x_bias,x_scale,y_bias,y_scale) = data_norms
    x_norm = (x .- x_bias) ./ x_scale

    % get results
    y_hat = linear_fwd(x_norm,y_bias,y_scale,model)

end % function linear_fwd
end
