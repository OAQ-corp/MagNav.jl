% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_map(map_map::Matrix, map_xx::Vector       = [], map_yy::Vector       = []; clims::Tuple         = (),
% Mechanical conversion draft: review before production use.
function p1 = plot_map(map_map, map_xx, map_yy, varargin)
                  map_xx::Vector       = [],
                  map_yy::Vector       = [];
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
    p1 = plot(legend=legend,lab=false)
    plot_map!(p1,map_map,map_xx,map_yy;
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
end % function plot_map
end
