% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_path(p1::Plot, lat, lon; lab::String        = "", Nmax::Int          = 5000, show_plot::Bool    = true, zoom_plot::Bool    = false, path_color::Symbol = :ignore)
% Mechanical conversion draft: review before production use.
function p2 = plot_path(p1, lat, lon, varargin)
                   lab::String        = "",
                   Nmax::Int          = 5000,
                   show_plot::Bool    = true,
                   zoom_plot::Bool    = false,
                   path_color::Symbol = :ignore)
    p2 = deepcopy(p1)
    plot_path!(p2,lat,lon;
               lab        = lab,
               Nmax       = Nmax,
               show_plot  = show_plot,
               zoom_plot  = zoom_plot,
               path_color = path_color)
end % function plot_path
end
