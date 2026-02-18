% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_path(lat, lon; lab::String        = "", dpi::Int           = 200, margin::Int        = 2, Nmax::Int          = 5000, show_plot::Bool    = true, zoom_plot::Bool    = true, path_color::Symbol = :ignore)
% Mechanical conversion draft: review before production use.
function p1 = plot_path__ovl3(lat, lon, varargin)
                   lab::String        = "",
                   dpi::Int           = 200,
                   margin::Int        = 2,
                   Nmax::Int          = 5000,
                   show_plot::Bool    = true,
                   zoom_plot::Bool    = true,
                   path_color::Symbol = :ignore)
    p1 = plot(xlab="longitude [deg]",ylab="latitude [deg]",
              dpi=dpi,margin=margin*mm)
    plot_path!(p1,lat,lon;
               lab        = lab,
               Nmax       = Nmax,
               show_plot  = show_plot,
               zoom_plot  = zoom_plot,
               path_color = path_color)
end % function plot_path
end
