% Auto-generated from src/analysis_util.jl
% Original Julia signature: function norm_sets(train; norm_type::Symbol = :standardize, no_norm           = falses(size(train,2)))
% Mechanical conversion draft: review before production use.
function out = norm_sets(train, varargin)
                   norm_type::Symbol = :standardize,
                   no_norm           = falses(size(train,2)))

    if !(no_norm isa AbstractVector{Bool})
        no_norm = axes(train,2) .∈ (no_norm,)
    end
end
