% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_map!(p1::Plot, p2::Plot, p3::Plot, mapV::MapV; use_mask::Bool       = true, clims::Tuple         = (),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_map_bang__ovl3(p1, p2, p3, mapV, varargin)
    out = [];
% TODO(Julia->MATLAB): use_mask::Bool       = true,
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
    map_mask = use_mask ? mapV.mask : trues(size(mapV.map))
% TODO(Julia->MATLAB): for (p_,map_) in zip([p1,p2,p3],[mapV.mapX,mapV.mapY,mapV.mapZ])
% TODO(Julia->MATLAB): plot_map!(p_,map_.*map_mask,mapV.xx,mapV.yy;
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
