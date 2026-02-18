% Auto-generated from src/mpf.jl
% Original Julia signature: function sys_resample(q)
% Mechanical conversion draft: review before production use.
function out = sys_resample(q)
    qc = cumsum(q)
    np = length(q)
    u  = ((1:np) .- rand(eltype(q),1)) ./ np
    i  = zeros(Int,np)
    k  = 1

    for j = 1:np
        while (qc[k] < u[j]) & (k < np)
            k += 1
        end
end
