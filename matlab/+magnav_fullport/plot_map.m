% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_map(map_map::Matrix, map_xx::Vector       = [], map_yy::Vector       = []; clims::Tuple         = (),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = plot_map(map_map, map_xx, map_yy, varargin)
    p1 = [];
% TODO(Julia->MATLAB): map_xx::Vector       = [],
% TODO(Julia->MATLAB): map_yy::Vector       = [];
% TODO(Julia->MATLAB): clims::Tuple         = (),
% TODO(Julia->MATLAB): dpi::Int             = 200,
% TODO(Julia->MATLAB): margin::Int          = 2,
% TODO(Julia->MATLAB): Nmax::Int            = 6*dpi,
% TODO(Julia->MATLAB): legend::Bool         = true,
% TODO(Julia->MATLAB): axis::Bool           = true,
% TODO(Julia->MATLAB): map_color::Symbol    = :usgs,
% TODO(Julia->MATLAB): bg_color::Symbol     = :white,
% TODO(Julia->MATLAB): map_units::Symbol    = :rad,
% TODO(Julia->MATLAB): plot_units::Symbol   = :deg,
% TODO(Julia->MATLAB): b_e::AbstractBackend = gr())
    b_e % backend
    p1 = plot(legend=legend,lab=false)
% TODO(Julia->MATLAB): plot_map!(p1,map_map,map_xx,map_yy;
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
% return (p1)
end % function plot_map
end
