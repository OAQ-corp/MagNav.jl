% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_check(map_map::Map, lat, lon, alt = fill(median(map_map.alt),size(lat)))
% Mechanical conversion draft: review before production use.
function out = map_check(map_map, lat, lon, alt, size_lat__)
    map_mask = convert.(eltype(map_map.alt),map_map.mask)
    if map_map isa Union{MapS,MapSd,MapV}
        itp_mask = map_itp(map_mask,map_map.xx,map_map.yy,:linear)
    elseif map_map isa MapS3D
        itp_mask = map_itp(map_mask,map_map.xx,map_map.yy,:linear,map_map.alt)
    end
end
