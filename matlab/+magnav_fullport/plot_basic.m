% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_basic(tt::Vector, y::Vector, ind = trues(length(tt));
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = plot_basic(tt, y, ind)
    p1 = [];
% TODO(Julia->MATLAB): lab::String      = "",
% TODO(Julia->MATLAB): xlab::String     = "time [min]",
% TODO(Julia->MATLAB): ylab::String     = "",
% TODO(Julia->MATLAB): show_plot::Bool  = true,
% TODO(Julia->MATLAB): save_plot::Bool  = false,
% TODO(Julia->MATLAB): plot_png::String = "data_vs_time.png")

% TODO(Julia->MATLAB): p1 = plot((tt(ind) .- tt(ind)[1]) / 60, y(ind),lab=lab,xlab=xlab,ylab=ylab)

    show_plot && display(p1)
    save_plot && png(p1,plot_png)

% return (p1)
end % function plot_basic
end
