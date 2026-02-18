% Auto-generated from src/eval_filt.jl
% Original Julia signature: function chisq_pdf(x, k::Int = 1)
% Mechanical conversion draft: review before production use.
function out = chisq_pdf(x, k)
    f = x > 0 ? x^(k/2-1) * exp(-x/2) / (2^(k/2) * gamma(k/2)) : 0
end % function chisq_pdf
end
