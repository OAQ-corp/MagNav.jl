% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_nn_m(Nf::Int, Ny::Int = 1; hidden                = [8], activation::Function  = swish, final_bias::Bool      = true, skip_con::Bool        = false, model_type::Symbol    = :m1, l_window::Int         = 5, tf_layer_type::Symbol = :postlayer, tf_norm_type::Symbol  = :batch, dropout_prob::Real    = 0.2, N_tf_head::Int        = 8, tf_gain::Real         = 1.0)
% Mechanical conversion draft: review before production use.
function out = get_nn_m(Nf, Ny, varargin)
                  hidden                = [8],
                  activation::Function  = swish,
                  final_bias::Bool      = true,
                  skip_con::Bool        = false,
                  model_type::Symbol    = :m1,
                  l_window::Int         = 5,
                  tf_layer_type::Symbol = :postlayer,
                  tf_norm_type::Symbol  = :batch,
                  dropout_prob::Real    = 0.2,
                  N_tf_head::Int        = 8,
                  tf_gain::Real         = 1.0)

    l = length(hidden)

    if model_type == :m3tf

        % pre & post layer normalization transformer architectures
        % https://tnq177.github.io/data/transformers_without_tears.pdf

        assert l > 0 "hidden must have at least 1 element"
        assert hidden[1] % N_tf_head == 0 "hidden[1] must be divisible by N_tf_head"

        N_head = hidden[1]
        init   = Flux.glorot_uniform(gain=tf_gain)

        if tf_norm_type == :layer
            norm_layer1 = LayerNorm(N_head)
            norm_layer2 = LayerNorm(N_head)
        elseif tf_norm_type == :batch
            norm_layer1 = x -> batchnorm(x)
            norm_layer2 = x -> batchnorm(x)
        elseif tf_norm_type == :none
            norm_layer1 = identity
            norm_layer2 = identity
        else
            error("tf_norm_type $tf_norm_type is invalid, select {:batch,:layer,:none}")
        end
end
