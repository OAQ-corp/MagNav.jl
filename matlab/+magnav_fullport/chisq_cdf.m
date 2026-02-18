% Auto-generated from src/eval_filt.jl
% Original Julia signature: function chisq_cdf(x, k::Int = 1)
% Mechanical conversion draft: review before production use.
function out = chisq_cdf(x, k)
    F = x > 0 ? gamma_inc.(k/2,x/2)[1] : 0
end % function chisq_cdf
end
