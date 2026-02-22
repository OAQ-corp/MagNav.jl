% Auto-generated from src/map_functions.jl
% Original Julia signature: function get_step(x::AbstractVector)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_step(x)
    out = [];
    step(LinRange(x(1),x(end),length(x)))
end % function get_step
end
