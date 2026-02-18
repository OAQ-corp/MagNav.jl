% Auto-generated from src/analysis_util.jl
% Original Julia signature: function err_segs(y_hat, y, l_segs; silent::Bool = true)
% Mechanical conversion draft: review before production use.
function out = err_segs(y_hat, y, l_segs, varargin)
    err = y_hat - y
    for i in eachindex(l_segs)
        (i1,i2) = cumsum(l_segs)[i] .- (l_segs[i]-1,0)
        err[i1:i2] .-= mean(err[i1:i2])
        err_std = round(std(err[i1:i2]),digits=2)
        silent || @info("line %$i error: $err_std nT")
    end
end
