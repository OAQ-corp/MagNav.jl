% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_1_fwd(x::Matrix, data_norms::Tuple, model::Chain)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function y_hat = nn_comp_1_fwd__ovl2(x, data_norms, model)
    y_hat = [];

    % convert to Float32 for consistency with nn_comp_1_train
    x = Float32(x)

    % unpack data normalizations
    (_,_,v_scale,x_bias,x_scale,y_bias,y_scale) = unpack_data_norms(data_norms)
    x_norm = (((x .- x_bias) ./ x_scale) * v_scale)'

    % get results
    y_hat = nn_comp_1_fwd(x_norm,y_bias,y_scale,model)

% return (y_hat)
end % function nn_comp_1_fwd
end
