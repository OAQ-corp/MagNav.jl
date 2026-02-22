% Auto-generated from src/analysis_util.jl
% Original Julia signature: function err_segs(y_hat, y, l_segs; silent::Bool = true)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = err_segs(y_hat, y, l_segs, varargin)
    out = [];
    err = y_hat - y
% TODO(Julia->MATLAB): for i in eachindex(l_segs)
% TODO(Julia->MATLAB): (i1,i2) = cumsum(l_segs)[i] .- (l_segs(i)-1,0)
% TODO(Julia->MATLAB): err(i1:i2) .-= mean(err(i1:i2))
% TODO(Julia->MATLAB): err_std = round(std(err(i1:i2)),digits=2)
% TODO(Julia->MATLAB): silent || @info("line %$i error: $err_std nT")
    end
end
