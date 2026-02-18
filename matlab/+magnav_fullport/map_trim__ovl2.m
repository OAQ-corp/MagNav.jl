% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_trim(map_map::Map; pad::Int          = 0, xx_lim::Tuple     = (-Inf,Inf),
% Mechanical conversion draft: review before production use.
function out = map_trim__ovl2(map_map, varargin)
                  pad::Int          = 0,
                  xx_lim::Tuple     = (-Inf,Inf),
                  yy_lim::Tuple     = (-Inf,Inf),
                  zone_utm::Int     = 18,
                  is_north::Bool    = true,
                  map_units::Symbol = :rad,
                  silent::Bool      = true)

    if map_map isa Union{MapS,MapSd,MapS3D} % scalar map
        map_map isa MapS3D && @info("3D map provided, using map at lowest altitude")
        (ind_xx,ind_yy) = map_trim(map_map.map[:,:,1],map_map.xx,map_map.yy;
                                   pad=pad,xx_lim=xx_lim,yy_lim=yy_lim,
                                   zone_utm=zone_utm,is_north=is_north,
                                   map_units=map_units,silent=silent)
        if map_map isa MapS
                          map_map.xx[ind_xx],map_map.yy[ind_yy],
                          map_map.alt,map_map.mask[ind_yy,ind_xx])
        elseif map_map isa MapSd % drape map
                          map_map.xx[ind_xx],map_map.yy[ind_yy],
                          map_map.alt[ind_yy,ind_xx],map_map.mask[ind_yy,ind_xx])
        elseif map_map isa MapS3D % 3D map
                          map_map.xx[ind_xx],map_map.yy[ind_yy],
                          map_map.alt,map_map.mask[ind_yy,ind_xx,:])
        end
end
