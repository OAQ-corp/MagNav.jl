% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_map!(p1::Plot, p2::Plot, p3::Plot, mapV::MapV; use_mask::Bool       = true, clims::Tuple         = (),
% Mechanical conversion draft: review before production use.
function out = plot_map_bang__ovl3(p1, p2, p3, mapV, varargin)
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
    map_mask = use_mask ? mapV.mask : trues(size(mapV.map))
    for (p_,map_) in zip([p1,p2,p3],[mapV.mapX,mapV.mapY,mapV.mapZ])
        plot_map!(p_,map_.*map_mask,mapV.xx,mapV.yy;
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
