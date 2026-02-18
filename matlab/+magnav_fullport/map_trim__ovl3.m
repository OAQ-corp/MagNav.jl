% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_trim(map_map::Map, path::Path; pad::Int          = 0, zone_utm::Int     = 18, is_north::Bool    = true, map_units::Symbol = :rad, silent::Bool      = true)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_trim__ovl3(map_map, path, varargin)
    out = [];
% TODO(Julia->MATLAB): pad::Int          = 0,
% TODO(Julia->MATLAB): zone_utm::Int     = 18,
% TODO(Julia->MATLAB): is_north::Bool    = true,
% TODO(Julia->MATLAB): map_units::Symbol = :rad,
% TODO(Julia->MATLAB): silent::Bool      = true)
    map_trim(map_map;
             pad       = pad,
             xx_lim    = extrema(path.lon),
             yy_lim    = extrema(path.lat),
             zone_utm  = zone_utm,
             is_north  = is_north,
             map_units = map_units,
             silent    = silent)
end % function map_trim
end
