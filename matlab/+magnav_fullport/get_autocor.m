% Auto-generated from src/eval_filt.jl
% Original Julia signature: function get_autocor(x::Vector, dt = 0.1, dt_max = 300.0)
% Mechanical conversion draft: review before production use.
function [sigma, tau] = get_autocor(x, dt, dt_max)
    sigma = round(Int,std(x))
    dts   = 0:dt:dt_max
    lags  = round.(Int,dts/dt)
    x_ac  = autocor(x,lags)
    i     = findfirst(x_ac .< exp(-1))
    tau   = i isa Nothing ? dt_max : round(Int,dts[i])
end % function get_autocor
end
