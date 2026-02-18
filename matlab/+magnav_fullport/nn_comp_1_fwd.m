% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_1_fwd(x_norm::AbstractMatrix, y_bias, y_scale, model::Chain; denorm::Bool   = true, testmode::Bool = true)
% Mechanical conversion draft: review before production use.
function y_hat = nn_comp_1_fwd(x_norm, y_bias, y_scale, model, varargin)
                       denorm::Bool   = true,
                       testmode::Bool = true)

    % set to test mode in case model uses batchnorm or dropout
    m = model
    testmode && Flux.testmode!(m)

    % get results
    y_hat = vec(m(x_norm))

    denorm && (y_hat .= denorm_sets(y_bias,y_scale,y_hat))

end % function nn_comp_1_fwd
end
