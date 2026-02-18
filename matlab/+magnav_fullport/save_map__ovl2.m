% Auto-generated from src/get_map.jl
% Original Julia signature: function save_map(map_map::Map, map_h5::String = "map_data.h5"; map_border::Matrix = zeros(eltype(map_map.alt),1,1),
% Mechanical conversion draft: review before production use.
function out = save_map__ovl2(map_map, map_h5, varargin)
                  map_border::Matrix = zeros(eltype(map_map.alt),1,1),
                  map_units::Symbol  = :rad,
                  file_units::Symbol = :deg)
    if map_map isa MapV % vector map
        save_map((map_map.mapX,map_map.mapY,map_map.mapZ),
                 map_map.xx,map_map.yy,map_map.alt,map_h5;
                 map_info   = map_map.info,
                 map_mask   = map_map.mask,
                 map_border = map_border,
                 map_units  = map_units,
                 file_units = file_units)
    else % scalar map
        save_map(map_map.map,
                 map_map.xx,map_map.yy,map_map.alt,map_h5;
                 map_info   = map_map.info,
                 map_mask   = map_map.mask,
                 map_border = map_border,
                 map_units  = map_units,
                 file_units = file_units)
    end
end
