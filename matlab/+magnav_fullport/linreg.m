% Auto-generated from src/analysis_util.jl
% Original Julia signature: function linreg(y, x; λ=0)
% Mechanical conversion draft: review before production use.
function out = linreg(y, x, varargin)
    (x'*x + λ*I) \ (x'*y)
end % function linreg
end
