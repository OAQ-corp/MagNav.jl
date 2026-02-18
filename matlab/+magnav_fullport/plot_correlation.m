% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_correlation(x::Vector, y::Vector, xfeature::Symbol = :feature_1, yfeature::Symbol = :feature_2; lim::Real        = 0, dpi::Int         = 200, show_plot::Bool  = true, save_plot::Bool  = false, plot_png::String = "$xfeature-$yfeature.png", silent::Bool     = true)
% Mechanical conversion draft: review before production use.
function nothing = plot_correlation(x, y, xfeature, yfeature, varargin)
                          xfeature::Symbol = :feature_1,
                          yfeature::Symbol = :feature_2;
                          lim::Real        = 0,
                          dpi::Int         = 200,
                          show_plot::Bool  = true,
                          save_plot::Bool  = false,
                          plot_png::String = "$xfeature-$yfeature.png",
                          silent::Bool     = true)

    xyc   = cor(x,y)
    xys   = linreg(y,x)
    xlab  = "$xfeature"
    ylab  = "$yfeature"
    title = "$yfeature vs $xfeature"
    silent || println("$title, correlation & slope: $(round.([xyc,xys],digits=5))")

    if abs(xyc) > lim
        p1 = scatter(x,y,lab=false,dpi=dpi,title=title,
                     xlab=xlab,ylab=ylab,mc=:black,ms=2)
        show_plot && display(p1)
        save_plot && png(p1,plot_png)
    else
    end
end
