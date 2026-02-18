% Auto-generated from src/eval_filt.jl
% Original Julia signature: function plot_filt(traj::Traj, ins::INS, filt_out::FILTout; dpi::Int        = 200, Nmax::Int       = 5000, plot_vel::Bool  = false, show_plot::Bool = true, save_plot::Bool = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_filt__ovl2(traj, ins, filt_out, varargin)
    out = [];
% TODO(Julia->MATLAB): dpi::Int        = 200,
% TODO(Julia->MATLAB): Nmax::Int       = 5000,
% TODO(Julia->MATLAB): plot_vel::Bool  = false,
% TODO(Julia->MATLAB): show_plot::Bool = true,
% TODO(Julia->MATLAB): save_plot::Bool = false)
    p1 = plot()
    plot_filt(p1,traj,ins,filt_out;
              dpi       = dpi,
              Nmax      = Nmax,
              plot_vel  = plot_vel,
              show_plot = show_plot,
              save_plot = save_plot)
end % function plot_filt
end
