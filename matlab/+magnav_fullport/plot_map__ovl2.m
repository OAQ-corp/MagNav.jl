% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_map(map_map::Map; use_mask::Bool       = true, clims::Tuple         = (),
% Mechanical conversion draft: review before production use.
function [p1, p2, p3] = plot_map__ovl2(map_map, varargin)
                  use_mask::Bool       = true,
                  clims::Tuple         = (),
                  dpi::Int             = 200,
                  margin::Int          = 2,
                  Nmax::Int            = 6*dpi,
                  legend::Bool         = true,
                  axis::Bool           = true,
                  map_color::Symbol    = :usgs,
                  bg_color::Symbol     = :white,
                  map_units::Symbol    = :rad,
                  plot_units::Symbol   = :deg,
                  b_e::AbstractBackend = gr())
    b_e % backend
    if map_map isa Union{MapS,MapSd,MapS3D}
        p1 = plot(legend=legend,lab=false)
        plot_map!(p1,map_map;
                  use_mask   = use_mask,
                  clims      = clims,
                  dpi        = dpi,
                  margin     = margin,
                  Nmax       = Nmax,
                  legend     = legend,
                  axis       = axis,
                  map_color  = map_color,
                  bg_color   = bg_color,
                  map_units  = map_units,
                  plot_units = plot_units,
                  b_e        = b_e)
    elseif map_map isa MapV
        p1 = plot(legend=legend,lab=false)
        p2 = plot(legend=legend,lab=false)
        p3 = plot(legend=legend,lab=false)
        plot_map!(p1,p2,p3,map_map;
                  use_mask   = use_mask,
                  clims      = clims,
                  dpi        = dpi,
                  margin     = margin,
                  Nmax       = Nmax,
                  legend     = legend,
                  axis       = axis,
                  map_color  = map_color,
                  bg_color   = bg_color,
                  map_units  = map_units,
                  plot_units = plot_units,
                  b_e        = b_e)
    end
end
