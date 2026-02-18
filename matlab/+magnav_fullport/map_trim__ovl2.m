% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_trim(map_map::Map; pad::Int          = 0, xx_lim::Tuple     = (-Inf,Inf),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_trim__ovl2(map_map, varargin)
    out = [];
% TODO(Julia->MATLAB): pad::Int          = 0,
% TODO(Julia->MATLAB): xx_lim::Tuple     = (-Inf,Inf),
% TODO(Julia->MATLAB): yy_lim::Tuple     = (-Inf,Inf),
% TODO(Julia->MATLAB): zone_utm::Int     = 18,
% TODO(Julia->MATLAB): is_north::Bool    = true,
% TODO(Julia->MATLAB): map_units::Symbol = :rad,
% TODO(Julia->MATLAB): silent::Bool      = true)

    if map_map isa Union{MapS,MapSd,MapS3D} % scalar map
% TODO(Julia->MATLAB): map_map isa MapS3D && @info("3D map provided, using map at lowest altitude")
        (ind_xx,ind_yy) = map_trim(map_map.map(:,:,1),map_map.xx,map_map.yy;
                                   pad=pad,xx_lim=xx_lim,yy_lim=yy_lim,
                                   zone_utm=zone_utm,is_north=is_north,
                                   map_units=map_units,silent=silent)
        if map_map isa MapS
% return MapS(  map_map.info,map_map.map(ind_yy,ind_xx),
                          map_map.xx(ind_xx),map_map.yy(ind_yy),
                          map_map.alt,map_map.mask(ind_yy,ind_xx))
        elseif map_map isa MapSd % drape map
% return MapSd( map_map.info,map_map.map(ind_yy,ind_xx),
                          map_map.xx(ind_xx),map_map.yy(ind_yy),
                          map_map.alt(ind_yy,ind_xx),map_map.mask(ind_yy,ind_xx))
        elseif map_map isa MapS3D % 3D map
% return MapS3D(map_map.info,map_map.map(ind_yy,ind_xx,:),
                          map_map.xx(ind_xx),map_map.yy(ind_yy),
                          map_map.alt,map_map.mask(ind_yy,ind_xx,:))
        end
end
