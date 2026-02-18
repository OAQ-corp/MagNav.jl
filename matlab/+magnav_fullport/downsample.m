% Auto-generated from src/analysis_util.jl
% Original Julia signature: function downsample(x::AbstractVecOrMat, Nmax::Int = 1000)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = downsample(x, Nmax)
    out = [];
    N = size(x,1)
    if N <= Nmax
        x = deepcopy(x)
    else
        if x isa AbstractVector
% TODO(Julia->MATLAB): x = x(1:ceil(Int,N/Nmax):N)
        elseif x isa AbstractMatrix
% TODO(Julia->MATLAB): x = x(1:ceil(Int,N/Nmax):N,:)
        end
end
