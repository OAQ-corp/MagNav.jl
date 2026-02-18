% Auto-generated from src/analysis_util.jl
% Original Julia signature: function linreg(y, x; λ=0)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = linreg(y, x, varargin)
    out = [];
    (x'*x + λ*I) \ (x'*y)
end % function linreg
end
