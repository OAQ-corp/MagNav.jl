% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_3_fwd(A, Bt, B_dot, x, data_norms::Tuple, model::Chain; model_type::Symbol = :m3s, y_type::Symbol     = :d, TL_coef::Vector    = zeros(Float32,18),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function y_hat = nn_comp_3_fwd__ovl2(A, Bt, B_dot, x, data_norms, model, varargin)
    y_hat = [];
% TODO(Julia->MATLAB): model_type::Symbol = :m3s,
% TODO(Julia->MATLAB): y_type::Symbol     = :d,
% TODO(Julia->MATLAB): TL_coef::Vector    = zeros(Float32,18),
% TODO(Julia->MATLAB): terms_A            = [:permanent,:induced,:eddy],
% TODO(Julia->MATLAB): l_segs::Vector     = [size(x,1)],
% TODO(Julia->MATLAB): l_window::Int      = 5)

% TODO(Julia->MATLAB): assert y_type in [:a,:b,:c,:d] "unsupported y_type = $y_type for nn_comp_3"

    % convert to Float32 for consistency with nn_comp_3_train
    A       = Float32(A)
    Bt      = Float32(Bt)    % magnitude of total field measurements
    B_dot   = Float32(B_dot) % finite differences of total field vector
    x       = Float32(x)
    TL_coef = Float32(TL_coef)

    % assume all terms are stored, but they may be zero if not trained
    Bt_scale = 50000f0
    (TL_coef_p,TL_coef_i,TL_coef_e) = TL_vec2mat(TL_coef,terms_A;Bt_scale=Bt_scale)

    B_unit    = A(:,1:3)'     % normalized vector magnetometer reading
% TODO(Julia->MATLAB): B_vec     = B_unit .* Bt' % vector magnetometer to be used in TL
    B_vec_dot = B_dot'        % not exactly true, but internally consistent

    % unpack data normalizations
    (_,_,v_scale,x_bias,x_scale,y_bias,y_scale) = unpack_data_norms(data_norms)
    x_norm = (((x .- x_bias) ./ x_scale) * v_scale)'

% TODO(Julia->MATLAB): model_type in [:m3w,:m3tf] && (x_norm = get_temporal_data(x_norm,l_segs,l_window))

    % get results
    y_hat = nn_comp_3_fwd(B_unit,B_vec,B_vec_dot,
                          x_norm,y_bias,y_scale,model,
                          TL_coef_p,TL_coef_i,TL_coef_e;
                          model_type = model_type,
                          y_type     = y_type,
                          use_nn     = true,
                          denorm     = true,
                          testmode   = true)

% return (y_hat)
end % function nn_comp_3_fwd
end
