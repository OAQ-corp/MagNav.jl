% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_basic(tt::Vector, y::Vector, ind = trues(length(tt));
% Mechanical conversion draft: review before production use.
function p1 = plot_basic(tt, y, ind)
                    lab::String      = "",
                    xlab::String     = "time [min]",
                    ylab::String     = "",
                    show_plot::Bool  = true,
                    save_plot::Bool  = false,
                    plot_png::String = "data_vs_time.png")

    p1 = plot((tt[ind] .- tt[ind][1]) / 60, y[ind],lab=lab,xlab=xlab,ylab=ylab)

    show_plot && display(p1)
    save_plot && png(p1,plot_png)

end % function plot_basic
end
