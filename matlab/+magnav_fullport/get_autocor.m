% Auto-generated from src/eval_filt.jl
% Original Julia signature: function get_autocor(x::Vector, dt = 0.1, dt_max = 300.0)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [sigma, tau] = get_autocor(x, dt, dt_max)
    sigma = [];
    sigma = round(Int,std(x))
% TODO(Julia->MATLAB): dts   = 0:dt:dt_max
    lags  = round(Int,dts/dt)
    x_ac  = autocor(x,lags)
    i     = findfirst(x_ac .< exp(-1))
    tau   = i isa Nothing ? dt_max : round(Int,dts(i))
% return (sigma, tau)
end % function get_autocor
end
