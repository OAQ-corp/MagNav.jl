% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_path!(p1::Plot, lat, lon; lab::String        = "", Nmax::Int          = 5000, show_plot::Bool    = true, zoom_plot::Bool    = false, path_color::Symbol = :ignore)
% Mechanical conversion draft: review before production use.
function out = plot_path_bang(p1, lat, lon, varargin)
                    lab::String        = "",
                    Nmax::Int          = 5000,
                    show_plot::Bool    = true,
                    zoom_plot::Bool    = false,
                    path_color::Symbol = :ignore)

    lon = downsample(rad2deg.(lon),Nmax)
    lat = downsample(rad2deg.(lat),Nmax)

    if path_color == :ignore
        p1 = plot!(p1,lon,lat,lab=lab,legend=true)
    else
        p1 = plot!(p1,lon,lat,lab=lab,legend=true,lc=path_color)
    end
end
