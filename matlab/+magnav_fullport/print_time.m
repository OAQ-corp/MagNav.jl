% Auto-generated from src/compensation.jl
% Original Julia signature: function print_time(t::Real, digits::Int = 1)
% Mechanical conversion draft: review before production use.
function out = print_time(t, digits)
    if t < 60
        @info("time: $(round(t   ,digits=digits)) sec")
    else
        @info("time: $(round(t/60,digits=digits)) min")
    end
end
