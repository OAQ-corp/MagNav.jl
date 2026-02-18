% Auto-generated from src/analysis_util.jl
% Original Julia signature: function detrend(y, x = [eachindex(y);]; λ = 0, mean_only::Bool = false)
% Mechanical conversion draft: review before production use.
function out = detrend(y, x, varargin)
    if mean_only
        y = y .- mean(y)
    else
        x    = [one.(y) x]
        coef = linreg(y,x;λ=λ)
        y    = y - x*coef
    end
end
