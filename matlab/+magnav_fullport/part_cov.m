% Auto-generated from src/mpf.jl
% Original Julia signature: function part_cov(q, x, x_mean, P = 0)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function P_out = part_cov(q, x, x_mean, P)
    P_out = [];
    (nx,np) = size(x)
    P_temp  = x - repeat(x_mean,1,np)
    P_out   = repeat(q',nx,1).*P_temp*P_temp' .+ P
% return (P_out)
end % function part_cov
end
