% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_utm2lla(map_map::Matrix, map_xx::Vector, map_yy::Vector, alt, map_mask::BitMatrix; map_info::String = "Map", zone_utm::Int    = 18, is_north::Bool   = true, save_h5::Bool    = false, map_h5::String   = "map_data.h5")
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [map_map, map_xx, map_yy, map_mask] = map_utm2lla(map_map, map_xx, map_yy, alt, map_mask, varargin)
    map_map = [];
% TODO(Julia->MATLAB): alt, map_mask::BitMatrix;
% TODO(Julia->MATLAB): map_info::String = "Map",
% TODO(Julia->MATLAB): zone_utm::Int    = 18,
% TODO(Julia->MATLAB): is_north::Bool   = true,
% TODO(Julia->MATLAB): save_h5::Bool    = false,
% TODO(Julia->MATLAB): map_h5::String   = "map_data.h5")
    map_map  = float(map_map)
    map_xx   = float(map_xx)
    map_yy   = float(map_yy)
    alt      = float(alt)
    map_mask = true .* map_mask
% TODO(Julia->MATLAB): map_utm2lla!(map_map,map_xx,map_yy,alt,map_mask;
                 map_info = map_info,
                 zone_utm = zone_utm,
                 is_north = is_north,
                 save_h5  = save_h5,
                 map_h5   = map_h5)
% return (map_map, map_xx, map_yy, map_mask)
end % function map_utm2lla
end
