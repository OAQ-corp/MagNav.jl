% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_lim(x, frac=0)
% Mechanical conversion draft: review before production use.
function out = get_lim(x, frac)
    extrema(x) .+ (-frac,frac) .* (extrema(x)[2] - extrema(x)[1])
end % function get_lim
end
