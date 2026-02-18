% Auto-generated from src/eval_filt.jl
% Original Julia signature: function plot_autocor(x::Vector, dt = 0.1, dt_max = 300.0; show_plot::Bool  = true, save_plot::Bool  = false, plot_png::String = "autocor.png")
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = plot_autocor(x, dt, dt_max, varargin)
    p1 = [];
% TODO(Julia->MATLAB): show_plot::Bool  = true,
% TODO(Julia->MATLAB): save_plot::Bool  = false,
% TODO(Julia->MATLAB): plot_png::String = "autocor.png")

    (sigma,tau) = get_autocor(x,dt,dt_max) % 1002.17: σ = 5, τ ≈ 45

% TODO(Julia->MATLAB): @info("σ ≈ $sigma")
% TODO(Julia->MATLAB): @info("τ ≈ $tau")
% TODO(Julia->MATLAB): tau == dt_max && @info("τ not in range")

% TODO(Julia->MATLAB): dts  = 0:dt:dt_max
    lags = round(Int,dts/dt)
    x_ac = autocor(x,lags)
    p1   = plot(dts,x_ac,lab=false);

    show_plot && display(p1)
    save_plot && png(p1,plot_png)

% return (p1)
end % function plot_autocor
end
