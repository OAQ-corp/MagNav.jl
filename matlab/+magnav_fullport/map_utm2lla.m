% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_utm2lla(map_map::Matrix, map_xx::Vector, map_yy::Vector, alt, map_mask::BitMatrix; map_info::String = "Map", zone_utm::Int    = 18, is_north::Bool   = true, save_h5::Bool    = false, map_h5::String   = "map_data.h5")
% Mechanical conversion draft: review before production use.
function [map_map, map_xx, map_yy, map_mask] = map_utm2lla(map_map, map_xx, map_yy, alt, map_mask, varargin)
                     alt, map_mask::BitMatrix;
                     map_info::String = "Map",
                     zone_utm::Int    = 18,
                     is_north::Bool   = true,
                     save_h5::Bool    = false,
                     map_h5::String   = "map_data.h5")
    map_map  = float.(map_map)
    map_xx   = float.(map_xx)
    map_yy   = float.(map_yy)
    alt      = float.(alt)
    map_mask = true .* map_mask
    map_utm2lla!(map_map,map_xx,map_yy,alt,map_mask;
                 map_info = map_info,
                 zone_utm = zone_utm,
                 is_north = is_north,
                 save_h5  = save_h5,
                 map_h5   = map_h5)
end % function map_utm2lla
end
