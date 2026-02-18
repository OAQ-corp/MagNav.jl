% Auto-generated from src/eval_filt.jl
% Original Julia signature: function chisq_pdf(x, k::Int = 1)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = chisq_pdf(x, k)
    out = [];
    f = x > 0 ? x^(k/2-1) * exp(-x/2) / (2^(k/2) * gamma(k/2)) : 0
% return float(f)
end % function chisq_pdf
end
