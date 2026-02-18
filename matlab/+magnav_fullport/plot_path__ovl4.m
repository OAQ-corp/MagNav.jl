% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_path(path::Path, ind = trues(path.N);
% Mechanical conversion draft: review before production use.
function p1 = plot_path__ovl4(path, ind)
                   lab::String        = "",
                   dpi::Int           = 200,
                   margin::Int        = 2,
                   Nmax::Int          = 5000,
                   show_plot::Bool    = true,
                   zoom_plot::Bool    = true,
                   path_color::Symbol = :ignore)
    p1 = plot_path(path.lat[ind],path.lon[ind];
                   lab        = lab,
                   dpi        = dpi,
                   margin     = margin,
                   Nmax       = Nmax,
                   show_plot  = show_plot,
                   zoom_plot  = zoom_plot,
                   path_color = path_color)
end % function plot_path
end
