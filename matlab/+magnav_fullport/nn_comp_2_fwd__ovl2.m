% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_2_fwd(A::Matrix, x::Matrix, data_norms::Tuple, model::Chain; model_type::Symbol = :m2a, TL_coef::Vector    = zeros(Float32,18))
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function y_hat = nn_comp_2_fwd__ovl2(A, x, data_norms, model, varargin)
    y_hat = [];
% TODO(Julia->MATLAB): model_type::Symbol = :m2a,
% TODO(Julia->MATLAB): TL_coef::Vector    = zeros(Float32,18))

    % convert to Float32 for consistency with nn_comp_2_train
    A       = Float32(A)
    x       = Float32(x)
    TL_coef = Float32(TL_coef)

    % unpack data normalizations
    (A_bias,A_scale,v_scale,x_bias,x_scale,y_bias,y_scale) =
        unpack_data_norms(data_norms)
    A_norm = ( (A .- A_bias) ./ A_scale           )'
    x_norm = (((x .- x_bias) ./ x_scale) * v_scale)'

    TL_coef_norm = TL_coef ./ y_scale

    % get results
    y_hat = nn_comp_2_fwd(A_norm,x_norm,y_bias,y_scale,model;
                          model_type   = model_type,
                          TL_coef_norm = TL_coef_norm)

% return (y_hat)
end % function nn_comp_2_fwd
end
