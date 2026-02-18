% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_params(map_map::Map)
% Mechanical conversion draft: review before production use.
function out = map_params__ovl2(map_map)
    if map_map isa MapV % vector map
        map_params(map_map.mapX,map_map.xx,map_map.yy)
    else % scalar map
        map_params(map_map.map,map_map.xx,map_map.yy)
    end
end
