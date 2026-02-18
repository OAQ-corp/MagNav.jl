% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_path(path::Path, ind = trues(path.N);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = plot_path__ovl4(path, ind)
    p1 = [];
% TODO(Julia->MATLAB): lab::String        = "",
% TODO(Julia->MATLAB): dpi::Int           = 200,
% TODO(Julia->MATLAB): margin::Int        = 2,
% TODO(Julia->MATLAB): Nmax::Int          = 5000,
% TODO(Julia->MATLAB): show_plot::Bool    = true,
% TODO(Julia->MATLAB): zoom_plot::Bool    = true,
% TODO(Julia->MATLAB): path_color::Symbol = :ignore)
    p1 = plot_path(path.lat(ind),path.lon(ind);
                   lab        = lab,
                   dpi        = dpi,
                   margin     = margin,
                   Nmax       = Nmax,
                   show_plot  = show_plot,
                   zoom_plot  = zoom_plot,
                   path_color = path_color)
% return (p1)
end % function plot_path
end
