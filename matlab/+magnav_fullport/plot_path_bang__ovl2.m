% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_path!(p1::Plot, path::Path, ind = trues(path.N);
% Mechanical conversion draft: review before production use.
function nothing = plot_path_bang__ovl2(p1, path, ind)
                    lab::String        = "",
                    Nmax::Int          = 5000,
                    show_plot::Bool    = true,
                    zoom_plot::Bool    = false,
                    path_color::Symbol = :ignore)
    plot_path!(p1,path.lat[ind],path.lon[ind];
               lab        = lab,
               Nmax       = Nmax,
               show_plot  = show_plot,
               zoom_plot  = zoom_plot,
               path_color = path_color)
end % function plot_path!
end
