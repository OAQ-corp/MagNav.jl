% Auto-generated from src/analysis_util.jl
% Original Julia signature: function expand_range(x::Vector, xlim::Tuple = get_lim(x),
% Mechanical conversion draft: review before production use.
function out = expand_range(x, xlim)
                      extra_step::Bool = false)
    dx = get_step(x)
    imin = 0
    (xmin,xmax) = extrema(x)
    while minimum(xlim) < xmin
        imin += 1
        xmin -= dx
    end
end
