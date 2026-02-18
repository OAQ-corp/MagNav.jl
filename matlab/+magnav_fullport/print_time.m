% Auto-generated from src/compensation.jl
% Original Julia signature: function print_time(t::Real, digits::Int = 1)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = print_time(t, digits)
    out = [];
    if t < 60
% TODO(Julia->MATLAB): @info("time: $(round(t   ,digits=digits)) sec")
    else
% TODO(Julia->MATLAB): @info("time: $(round(t/60,digits=digits)) min")
    end
end
