% Auto-generated from src/compensation.jl
% Original Julia signature: function nn_comp_2_train(A, x, y, no_norm = falses(size(x,2));
% Mechanical conversion draft: review before production use.
function out = nn_comp_2_train(A, x, y, no_norm, f_2_)
                         model_type::Symbol   = :m2a,
                         norm_type_A::Symbol  = :none,
                         norm_type_x::Symbol  = :standardize,
                         norm_type_y::Symbol  = :none,
                         TL_coef::Vector      = zeros(Float32,18),
                         η_adam               = 0.001,
                         epoch_adam::Int      = 5,
                         epoch_lbfgs::Int     = 0,
                         hidden               = [8],
                         activation::Function = swish,
                         loss::Function       = mse,
                         batchsize::Int       = 2048,
                         frac_train           = 14/17,
                         α_sgl                = 1,
                         λ_sgl                = 0,
                         k_pca::Int           = -1,
                         data_norms::Tuple    = (zeros(Float32,1,1),zeros(Float32,1,1),zeros(Float32,1,1),zeros(Float32,1,1),zeros(Float32,1,1),[0f0],[0f0]),
                         model::Chain         = Chain(),
                         l_segs::Vector       = [length(y)],
                         A_test::Matrix       = Matrix{eltype(A)}(undef,0,0),
                         x_test::Matrix       = Matrix{eltype(x)}(undef,0,0),
                         y_test::Vector       = Vector{eltype(y)}(undef,0),
                         l_segs_test::Vector  = [length(y_test)],
                         silent::Bool         = false)

    % convert to Float32 for ~50% speedup
    A       = Float32.(A)
    x       = Float32.(x)
    y       = Float32.(y)
    α       = Float32.(α_sgl)
    λ       = Float32.(λ_sgl)
    A_test  = Float32.(A_test)
    x_test  = Float32.(x_test)
    y_test  = Float32.(y_test)
    TL_coef = Float32.(TL_coef)

    Nf = size(x,2) % number of features

    if sum(data_norms[end]) == 0 % normalize data
        (A_bias,A_scale,A_norm) = norm_sets(A;norm_type=norm_type_A)
        (x_bias,x_scale,x_norm) = norm_sets(x;norm_type=norm_type_x,no_norm=no_norm)
        (y_bias,y_scale,y_norm) = norm_sets(y;norm_type=norm_type_y)
        if k_pca > 0
            if k_pca > Nf
                silent || @info("reducing k_pca from $k_pca to $Nf")
                k_pca = Nf
            end
end
