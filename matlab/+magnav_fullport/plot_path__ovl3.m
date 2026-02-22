% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_path(lat, lon; lab::String        = "", dpi::Int           = 200, margin::Int        = 2, Nmax::Int          = 5000, show_plot::Bool    = true, zoom_plot::Bool    = true, path_color::Symbol = :ignore)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = plot_path__ovl3(lat, lon, varargin)
    p1 = [];
% TODO(Julia->MATLAB): lab::String        = "",
% TODO(Julia->MATLAB): dpi::Int           = 200,
% TODO(Julia->MATLAB): margin::Int        = 2,
% TODO(Julia->MATLAB): Nmax::Int          = 5000,
% TODO(Julia->MATLAB): show_plot::Bool    = true,
% TODO(Julia->MATLAB): zoom_plot::Bool    = true,
% TODO(Julia->MATLAB): path_color::Symbol = :ignore)
    p1 = plot(xlab="longitude [deg]",ylab="latitude [deg]",
              dpi=dpi,margin=margin*mm)
% TODO(Julia->MATLAB): plot_path!(p1,lat,lon;
               lab        = lab,
               Nmax       = Nmax,
               show_plot  = show_plot,
               zoom_plot  = zoom_plot,
               path_color = path_color)
% return (p1)
end % function plot_path
end
