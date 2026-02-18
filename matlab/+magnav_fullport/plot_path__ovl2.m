% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_path(p1::Plot, path::Path, ind = trues(path.N);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p2 = plot_path__ovl2(p1, path, ind)
    p2 = [];
% TODO(Julia->MATLAB): lab::String        = "",
% TODO(Julia->MATLAB): Nmax::Int          = 5000,
% TODO(Julia->MATLAB): show_plot::Bool    = true,
% TODO(Julia->MATLAB): zoom_plot::Bool    = false,
% TODO(Julia->MATLAB): path_color::Symbol = :ignore)
    p2 = deepcopy(p1)
% TODO(Julia->MATLAB): plot_path!(p2,path.lat(ind),path.lon(ind);
               lab        = lab,
               Nmax       = Nmax,
               show_plot  = show_plot,
               zoom_plot  = zoom_plot,
               path_color = path_color)
% return (p2)
end % function plot_path
end
