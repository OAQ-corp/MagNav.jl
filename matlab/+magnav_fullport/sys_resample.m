% Auto-generated from src/mpf.jl
% Original Julia signature: function sys_resample(q)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = sys_resample(q)
    out = [];
    qc = cumsum(q)
    np = length(q)
% TODO(Julia->MATLAB): u  = ((1:np) .- rand(eltype(q),1)) ./ np
    i  = zeros(Int,np)
    k  = 1

% TODO(Julia->MATLAB): for j = 1:np
        while (qc(k) < u(j)) & (k < np)
% TODO(Julia->MATLAB): k += 1
        end
end
