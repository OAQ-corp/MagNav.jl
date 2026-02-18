% Auto-generated from src/analysis_util.jl
% Original Julia signature: function norm_sets(train, test; norm_type::Symbol = :standardize, no_norm           = falses(size(train,2)))
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = norm_sets__ovl2(train, test, varargin)
    out = [];
% TODO(Julia->MATLAB): norm_type::Symbol = :standardize,
                   no_norm           = falses(size(train,2)))

% TODO(Julia->MATLAB): if !(no_norm isa AbstractVector{Bool})
        no_norm = axes(train,2) .∈ (no_norm,)
    end
end
