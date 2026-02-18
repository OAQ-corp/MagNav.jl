% Auto-generated from src/get_map.jl
% Original Julia signature: function save_map(map_map, map_xx, map_yy, map_alt, map_h5::String = "map_data.h5"; map_info::String   = "Map", map_mask::BitArray = falses(1,1),
% Mechanical conversion draft: review before production use.
function out = save_map(map_map, map_xx, map_yy, map_alt, map_h5, varargin)
                  map_info::String   = "Map",
                  map_mask::BitArray = falses(1,1),
                  map_border::Matrix = zeros(eltype(map_alt),1,1),
                  map_units::Symbol  = :rad,
                  file_units::Symbol = :deg)

    map_h5 = add_extension(map_h5,".h5")

    map_xx = vec(map_xx)
    map_yy = vec(map_yy)

    if (map_units == :rad) & (file_units == :deg)
        map_xx     = rad2deg.(map_xx)
        map_yy     = rad2deg.(map_yy)
        map_border = rad2deg.(map_border)
    elseif (map_units == :deg) & (file_units == :rad)
        map_xx     = deg2rad.(map_xx)
        map_yy     = deg2rad.(map_yy)
        map_border = deg2rad.(map_border)
    elseif map_units ~= file_units
        error("[$map_units] map xx/yy units ≠ [$file_units] map file xx/yy units")
    elseif map_units ∉ [:rad,:deg]
        @info("[$map_units] map xx/yy units not defined")
    end
end
