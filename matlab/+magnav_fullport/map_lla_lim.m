% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_lla_lim(map_xx::Vector, map_yy::Vector; xx_1::Int      = 1, xx_nx::Int     = length(map_xx),
% Mechanical conversion draft: review before production use.
function [lons, lats] = map_lla_lim(map_xx, map_yy, varargin)
                     xx_1::Int      = 1,
                     xx_nx::Int     = length(map_xx),
                     yy_1::Int      = 1,
                     yy_ny::Int     = length(map_yy),
                     zone_utm::Int  = 18,
                     is_north::Bool = true)

    % 4 corners of UTM map
    utm2lla = LLAfromUTM(zone_utm,is_north,WGS84)
    x       = map_xx[[xx_1,xx_1,xx_nx,xx_nx]]
    y       = map_yy[[yy_1,yy_ny,yy_1,yy_ny]]
    llas    = utm2lla.(UTM.(x,y))

    % sorted longitudes at 4 corners of UTM map
    % left/right edges are straight, so only corners needed
    lons = sort([lla.lon for lla in llas])

    % lower/upper parallels of UTM map
    x       = map_xx[xx_1:xx_nx]
    llas_1  = utm2lla.(UTM.(x,map_yy[yy_1 ]))
    llas_ny = utm2lla.(UTM.(x,map_yy[yy_ny]))

    % sorted latitude limits for lower/upper parallels of UTM map
    lats = sort([extrema([lla.lat for lla in llas_1 ])...,
                 extrema([lla.lat for lla in llas_ny])...])

end % function map_lla_lim
end
