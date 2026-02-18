% Auto-generated from src/map_functions.jl
% Original Julia signature: function get_step(x::AbstractVector)
% Mechanical conversion draft: review before production use.
function out = get_step(x)
    step(LinRange(x[1],x[end],length(x)))
end % function get_step
end
