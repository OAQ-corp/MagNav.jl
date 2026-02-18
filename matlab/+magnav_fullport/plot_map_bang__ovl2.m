% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_map!(p1::Plot, mapS::Union{MapS,MapSd,MapS3D}; use_mask::Bool       = true, clims::Tuple         = (),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function nothing = plot_map_bang__ovl2(p1, mapS, MapSd, MapS3D_, varargin)
    nothing = [];
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
% TODO(Julia->MATLAB): mapS isa MapS3D && @info("3D map provided, using map at lowest altitude")
    map_mask = use_mask ? mapS.mask(:,:,1) : trues(size(mapS.map(:,:,1)))
% TODO(Julia->MATLAB): plot_map!(p1,mapS.map(:,:,1).*map_mask,mapS.xx,mapS.yy;
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
% return ([])
end % function plot_map!
end
