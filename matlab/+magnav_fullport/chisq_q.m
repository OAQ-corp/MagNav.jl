% Auto-generated from src/eval_filt.jl
% Original Julia signature: function chisq_q(P = 0.95, k::Int = 1)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = chisq_q(P, k)
    out = [];
    gamma_inc_inv(k/2,P,1-P)*2
end % function chisq_q
end
