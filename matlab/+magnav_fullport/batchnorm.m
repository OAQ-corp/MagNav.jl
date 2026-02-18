% Auto-generated from src/analysis_util.jl
% Original Julia signature: function batchnorm(x::AbstractArray)
% Mechanical conversion draft: review before production use.
function x_b = batchnorm(x)
    c   = size(x,1)
    d   = (2,1,3)
    x_b = permutedims(BatchNorm(c)(permutedims(x,d)), d)
end % function batchnorm
end
