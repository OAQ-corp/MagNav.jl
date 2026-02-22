% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_lla_lim(map_xx::Vector, map_yy::Vector; xx_1::Int      = 1, xx_nx::Int     = length(map_xx),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [lons, lats] = map_lla_lim(map_xx, map_yy, varargin)
    lons = [];
% TODO(Julia->MATLAB): xx_1::Int      = 1,
% TODO(Julia->MATLAB): xx_nx::Int     = length(map_xx),
% TODO(Julia->MATLAB): yy_1::Int      = 1,
% TODO(Julia->MATLAB): yy_ny::Int     = length(map_yy),
% TODO(Julia->MATLAB): zone_utm::Int  = 18,
% TODO(Julia->MATLAB): is_north::Bool = true)

    % 4 corners of UTM map
    utm2lla = LLAfromUTM(zone_utm,is_north,WGS84)
    x       = map_xx([xx_1,xx_1,xx_nx,xx_nx)]
    y       = map_yy([yy_1,yy_ny,yy_1,yy_ny)]
    llas    = utm2lla(UTM(x,y))

    % sorted longitudes at 4 corners of UTM map
    % left/right edges are straight, so only corners needed
% TODO(Julia->MATLAB): lons = sort([lla.lon for lla in llas])

    % lower/upper parallels of UTM map
% TODO(Julia->MATLAB): x       = map_xx(xx_1:xx_nx)
    llas_1  = utm2lla(UTM(x,map_yy(yy_1 )))
    llas_ny = utm2lla(UTM(x,map_yy(yy_ny)))

    % sorted latitude limits for lower/upper parallels of UTM map
% TODO(Julia->MATLAB): lats = sort([extrema([lla.lat for lla in llas_1 ])...,
% TODO(Julia->MATLAB): extrema([lla.lat for lla in llas_ny])...])

% return (lons, lats)
end % function map_lla_lim
end
