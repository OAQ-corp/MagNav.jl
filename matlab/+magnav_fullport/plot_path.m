% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_path(p1::Plot, lat, lon; lab::String        = "", Nmax::Int          = 5000, show_plot::Bool    = true, zoom_plot::Bool    = false, path_color::Symbol = :ignore)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p2 = plot_path(p1, lat, lon, varargin)
    p2 = [];
% TODO(Julia->MATLAB): lab::String        = "",
% TODO(Julia->MATLAB): Nmax::Int          = 5000,
% TODO(Julia->MATLAB): show_plot::Bool    = true,
% TODO(Julia->MATLAB): zoom_plot::Bool    = false,
% TODO(Julia->MATLAB): path_color::Symbol = :ignore)
    p2 = deepcopy(p1)
% TODO(Julia->MATLAB): plot_path!(p2,lat,lon;
               lab        = lab,
               Nmax       = Nmax,
               show_plot  = show_plot,
               zoom_plot  = zoom_plot,
               path_color = path_color)
% return (p2)
end % function plot_path
end
