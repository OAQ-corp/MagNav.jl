% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_map!(p1::Plot, mapS::Union{MapS,MapSd,MapS3D}; use_mask::Bool       = true, clims::Tuple         = (),
% Mechanical conversion draft: review before production use.
function nothing = plot_map_bang__ovl2(p1, mapS, MapSd, MapS3D_, varargin)
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
    mapS isa MapS3D && @info("3D map provided, using map at lowest altitude")
    map_mask = use_mask ? mapS.mask[:,:,1] : trues(size(mapS.map[:,:,1]))
    plot_map!(p1,mapS.map[:,:,1].*map_mask,mapS.xx,mapS.yy;
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
end % function plot_map!
end
