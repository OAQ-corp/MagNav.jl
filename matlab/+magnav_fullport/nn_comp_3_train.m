% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_3_train(A, Bt, B_dot, x, y, no_norm = falses(size(x,2));
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = nn_comp_3_train(A, Bt, B_dot, x, y, no_norm, f_2_)
    out = [];
% TODO(Julia->MATLAB): model_type::Symbol    = :m3s,
% TODO(Julia->MATLAB): norm_type_x::Symbol   = :standardize,
% TODO(Julia->MATLAB): norm_type_y::Symbol   = :standardize,
% TODO(Julia->MATLAB): TL_coef::Vector       = zeros(Float32,18),
% TODO(Julia->MATLAB): terms_A               = [:permanent,:induced,:eddy],
% TODO(Julia->MATLAB): y_type::Symbol        = :d,
                         η_adam                = 0.001,
% TODO(Julia->MATLAB): epoch_adam::Int       = 5,
% TODO(Julia->MATLAB): epoch_lbfgs::Int      = 0,
                         hidden                = [8],
% TODO(Julia->MATLAB): activation::Function  = swish,
% TODO(Julia->MATLAB): loss::Function        = mse,
% TODO(Julia->MATLAB): batchsize::Int        = 2048,
                         frac_train            = 14/17,
                         α_sgl                 = 1,
                         λ_sgl                 = 0,
% TODO(Julia->MATLAB): k_pca::Int            = -1,
                         σ_curriculum          = 1.0,
% TODO(Julia->MATLAB): l_window::Int         = 5,
% TODO(Julia->MATLAB): window_type::Symbol   = :sliding,
% TODO(Julia->MATLAB): tf_layer_type::Symbol = :postlayer,
% TODO(Julia->MATLAB): tf_norm_type::Symbol  = :batch,
                         dropout_prob          = 0.2,
% TODO(Julia->MATLAB): N_tf_head::Int        = 8,
                         tf_gain               = 1.0,
% TODO(Julia->MATLAB): data_norms::Tuple     = (zeros(Float32,1,1),zeros(Float32,1,1),zeros(Float32,1,1),zeros(Float32,1,1),zeros(Float32,1,1),[0f0],[0f0]),
% TODO(Julia->MATLAB): model::Chain          = Chain(),
% TODO(Julia->MATLAB): l_segs::Vector        = [length(y)],
% TODO(Julia->MATLAB): A_test::Matrix        = Matrix{eltype(A)}(undef,0,0),
% TODO(Julia->MATLAB): Bt_test::Vector       = Vector{eltype(Bt)}(undef,0),
% TODO(Julia->MATLAB): B_dot_test::Matrix    = Matrix{eltype(B_dot)}(undef,0,0),
% TODO(Julia->MATLAB): x_test::Matrix        = Matrix{eltype(x)}(undef,0,0),
% TODO(Julia->MATLAB): y_test::Vector        = Vector{eltype(y)}(undef,0),
% TODO(Julia->MATLAB): l_segs_test::Vector   = [length(y_test)],
% TODO(Julia->MATLAB): silent::Bool          = false)

% TODO(Julia->MATLAB): assert (α_sgl,λ_sgl) == (1,0)  "sparse group Lasso not implemented in nn_comp_3"
% TODO(Julia->MATLAB): assert y_type in [:a,:b,:c,:d] "unsupported y_type = $y_type for nn_comp_3"

    % convert to Float32 for ~50% speedup
    A          = Float32(A)
    Bt         = Float32(Bt)    % magnitude of total field measurements
    B_dot      = Float32(B_dot) % finite differences of total field vector
    x          = Float32(x)
    y          = Float32(y)
    A_test     = Float32(A_test)
    Bt_test    = Float32(Bt_test)
    B_dot_test = Float32(B_dot_test)
    x_test     = Float32(x_test)
    y_test     = Float32(y_test)
    TL_coef    = Float32(TL_coef)

    Nf = size(x,2) % number of features

    % assume all terms are stored, but they may be zero if not trained
    Bt_scale = 50000f0
    (TL_coef_p,TL_coef_i,TL_coef_e) = TL_vec2mat(TL_coef,terms_A;Bt_scale=Bt_scale)

    B_unit    = A(:,1:3)'     % normalized vector magnetometer reading
% TODO(Julia->MATLAB): B_vec     = B_unit .* Bt' % vector magnetometer to be used in TL
    B_vec_dot = B_dot'        % not exactly true, but internally consistent
    isempty(A_test)     || (B_unit_test    = A_test(:,1:3)')
    isempty(Bt_test)    || (B_vec_test     = B_unit_test .* Bt_test')
    isempty(B_dot_test) || (B_vec_dot_test = B_dot_test')

    if sum(data_norms(end)) == 0 % normalize data
        (x_bias,x_scale,x_norm) = norm_sets(x;norm_type=norm_type_x,no_norm=no_norm)
        (y_bias,y_scale,y_norm) = norm_sets(y;norm_type=norm_type_y)
        if k_pca > 0
            if k_pca > Nf
% TODO(Julia->MATLAB): silent || @info("reducing k_pca from $k_pca to $Nf")
                k_pca = Nf
            end
end
