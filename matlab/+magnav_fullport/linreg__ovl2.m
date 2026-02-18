% Auto-generated from src/analysis_util.jl
% Original Julia signature: function linreg(y; λ=0)
% Mechanical conversion draft: review before production use.
function coef = linreg__ovl2(y, varargin)
    x    = [one.(y) eachindex(y)]
    coef = linreg(y,x;λ=λ)
end % function linreg
end
