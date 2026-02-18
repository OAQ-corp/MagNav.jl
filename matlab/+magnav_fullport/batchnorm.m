% Auto-generated from src/analysis_util.jl
% Original Julia signature: function batchnorm(x::AbstractArray)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function x_b = batchnorm(x)
    x_b = [];
    c   = size(x,1)
    d   = (2,1,3)
    x_b = permutedims(BatchNorm(c)(permutedims(x,d)), d)
% return (x_b)
end % function batchnorm
end
