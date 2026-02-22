% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_2_train(A, x, y, no_norm = falses(size(x,2));
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = nn_comp_2_train(A, x, y, no_norm, f_2_)
    out = [];
% TODO(Julia->MATLAB): model_type::Symbol   = :m2a,
% TODO(Julia->MATLAB): norm_type_A::Symbol  = :none,
% TODO(Julia->MATLAB): norm_type_x::Symbol  = :standardize,
% TODO(Julia->MATLAB): norm_type_y::Symbol  = :none,
% TODO(Julia->MATLAB): TL_coef::Vector      = zeros(Float32,18),
                         η_adam               = 0.001,
% TODO(Julia->MATLAB): epoch_adam::Int      = 5,
% TODO(Julia->MATLAB): epoch_lbfgs::Int     = 0,
                         hidden               = [8],
% TODO(Julia->MATLAB): activation::Function = swish,
% TODO(Julia->MATLAB): loss::Function       = mse,
% TODO(Julia->MATLAB): batchsize::Int       = 2048,
                         frac_train           = 14/17,
                         α_sgl                = 1,
                         λ_sgl                = 0,
% TODO(Julia->MATLAB): k_pca::Int           = -1,
% TODO(Julia->MATLAB): data_norms::Tuple    = (zeros(Float32,1,1),zeros(Float32,1,1),zeros(Float32,1,1),zeros(Float32,1,1),zeros(Float32,1,1),[0f0],[0f0]),
% TODO(Julia->MATLAB): model::Chain         = Chain(),
% TODO(Julia->MATLAB): l_segs::Vector       = [length(y)],
% TODO(Julia->MATLAB): A_test::Matrix       = Matrix{eltype(A)}(undef,0,0),
% TODO(Julia->MATLAB): x_test::Matrix       = Matrix{eltype(x)}(undef,0,0),
% TODO(Julia->MATLAB): y_test::Vector       = Vector{eltype(y)}(undef,0),
% TODO(Julia->MATLAB): l_segs_test::Vector  = [length(y_test)],
% TODO(Julia->MATLAB): silent::Bool         = false)

    % convert to Float32 for ~50% speedup
    A       = Float32(A)
    x       = Float32(x)
    y       = Float32(y)
    α       = Float32(α_sgl)
    λ       = Float32(λ_sgl)
    A_test  = Float32(A_test)
    x_test  = Float32(x_test)
    y_test  = Float32(y_test)
    TL_coef = Float32(TL_coef)

    Nf = size(x,2) % number of features

    if sum(data_norms(end)) == 0 % normalize data
        (A_bias,A_scale,A_norm) = norm_sets(A;norm_type=norm_type_A)
        (x_bias,x_scale,x_norm) = norm_sets(x;norm_type=norm_type_x,no_norm=no_norm)
        (y_bias,y_scale,y_norm) = norm_sets(y;norm_type=norm_type_y)
        if k_pca > 0
            if k_pca > Nf
% TODO(Julia->MATLAB): silent || @info("reducing k_pca from $k_pca to $Nf")
                k_pca = Nf
            end
end
