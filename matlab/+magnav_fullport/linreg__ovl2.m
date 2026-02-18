% Auto-generated from src/analysis_util.jl
% Original Julia signature: function linreg(y; λ=0)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function coef = linreg__ovl2(y, varargin)
    coef = [];
    x    = [one(y) eachindex(y)]
    coef = linreg(y,x;λ=λ)
% return (coef)
end % function linreg
end
