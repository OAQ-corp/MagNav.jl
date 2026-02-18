% Auto-generated from src/analysis_util.jl
% Original Julia signature: function expand_range(x::Vector, xlim::Tuple = get_lim(x),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = expand_range(x, xlim)
    out = [];
% TODO(Julia->MATLAB): extra_step::Bool = false)
    dx = get_step(x)
    imin = 0
    (xmin,xmax) = extrema(x)
    while minimum(xlim) < xmin
% TODO(Julia->MATLAB): imin += 1
% TODO(Julia->MATLAB): xmin -= dx
    end
end
