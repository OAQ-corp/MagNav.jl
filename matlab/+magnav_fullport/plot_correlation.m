% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_correlation(x::Vector, y::Vector, xfeature::Symbol = :feature_1, yfeature::Symbol = :feature_2; lim::Real        = 0, dpi::Int         = 200, show_plot::Bool  = true, save_plot::Bool  = false, plot_png::String = "$xfeature-$yfeature.png", silent::Bool     = true)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function nothing = plot_correlation(x, y, xfeature, yfeature, varargin)
    nothing = [];
% TODO(Julia->MATLAB): xfeature::Symbol = :feature_1,
% TODO(Julia->MATLAB): yfeature::Symbol = :feature_2;
% TODO(Julia->MATLAB): lim::Real        = 0,
% TODO(Julia->MATLAB): dpi::Int         = 200,
% TODO(Julia->MATLAB): show_plot::Bool  = true,
% TODO(Julia->MATLAB): save_plot::Bool  = false,
% TODO(Julia->MATLAB): plot_png::String = "$xfeature-$yfeature.png",
% TODO(Julia->MATLAB): silent::Bool     = true)

    xyc   = cor(x,y)
    xys   = linreg(y,x)
% TODO(Julia->MATLAB): xlab  = "$xfeature"
% TODO(Julia->MATLAB): ylab  = "$yfeature"
% TODO(Julia->MATLAB): title = "$yfeature vs $xfeature"
% TODO(Julia->MATLAB): silent || println("$title, correlation & slope: $(round([xyc,xys],digits=5))")

    if abs(xyc) > lim
        p1 = scatter(x,y,lab=false,dpi=dpi,title=title,
% TODO(Julia->MATLAB): xlab=xlab,ylab=ylab,mc=:black,ms=2)
        show_plot && display(p1)
        save_plot && png(p1,plot_png)
% return (p1)
    else
% return ([])
    end
end
