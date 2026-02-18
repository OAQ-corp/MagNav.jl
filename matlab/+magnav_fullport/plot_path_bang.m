% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_path!(p1::Plot, lat, lon; lab::String        = "", Nmax::Int          = 5000, show_plot::Bool    = true, zoom_plot::Bool    = false, path_color::Symbol = :ignore)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_path_bang(p1, lat, lon, varargin)
    out = [];
% TODO(Julia->MATLAB): lab::String        = "",
% TODO(Julia->MATLAB): Nmax::Int          = 5000,
% TODO(Julia->MATLAB): show_plot::Bool    = true,
% TODO(Julia->MATLAB): zoom_plot::Bool    = false,
% TODO(Julia->MATLAB): path_color::Symbol = :ignore)

    lon = downsample(rad2deg(lon),Nmax)
    lat = downsample(rad2deg(lat),Nmax)

% TODO(Julia->MATLAB): if path_color == :ignore
% TODO(Julia->MATLAB): p1 = plot!(p1,lon,lat,lab=lab,legend=true)
    else
% TODO(Julia->MATLAB): p1 = plot!(p1,lon,lat,lab=lab,legend=true,lc=path_color)
    end
end
