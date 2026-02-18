% Auto-generated from src/analysis_util.jl
% Original Julia signature: function downsample(x::AbstractVecOrMat, Nmax::Int = 1000)
% Mechanical conversion draft: review before production use.
function out = downsample(x, Nmax)
    N = size(x,1)
    if N <= Nmax
        x = deepcopy(x)
    else
        if x isa AbstractVector
            x = x[1:ceil(Int,N/Nmax):N]
        elseif x isa AbstractMatrix
            x = x[1:ceil(Int,N/Nmax):N,:]
        end
end
