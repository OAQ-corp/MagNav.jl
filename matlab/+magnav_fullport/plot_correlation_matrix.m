% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_correlation_matrix(x::AbstractMatrix, features::Vector{Symbol}; dpi::Int         = 200, Nmax::Int        = 1000, show_plot::Bool  = true, save_plot::Bool  = false, plot_png::String = "correlation_matrix.png")
% Mechanical conversion draft: review before production use.
function out = plot_correlation_matrix(x, features, varargin)
                                 dpi::Int         = 200,
                                 Nmax::Int        = 1000,
                                 show_plot::Bool  = true,
                                 save_plot::Bool  = false,
                                 plot_png::String = "correlation_matrix.png")

    % %* note: this could be modified to use StatsPlots.corrplot():
    % https://github.com/JuliaPlots/StatsPlots.jl

    Nf = length(features)
    (Nf_min,Nf_max) = (2,5)
    assert Nf >= Nf_min "number of features = $Nf < $Nf_min"
    assert Nf <= Nf_max "number of features = $Nf > $Nf_max"

    p_ = []
    for j = 2:Nf, i = 1:Nf-1
        if j > i
            xlab   = j == Nf ? features[i] : ""
            ylab   = i == 1  ? features[j] : ""
            x_     = x[:,i]
            y_     = x[:,j]
            xticks = j == Nf ? round.(mean(x_) .+ [-1,1]*std(x_),sigdigits=3) : []
            yticks = i == 1  ? round.(mean(y_) .+ [-1,1]*std(y_),sigdigits=3) : []
            push!(p_,scatter(downsample(x_,Nmax),downsample(y_,Nmax),
                  lab=false,dpi=dpi,mc=:black,ms=1,
                  xlab=xlab,ylab=ylab,xticks=xticks,yticks=yticks,
                  xguidefontsize=8,yguidefontsize=8))
        end
end
