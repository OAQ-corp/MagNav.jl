% Auto-generated from src/get_map.jl
% Original Julia signature: function save_map(map_map, map_xx, map_yy, map_alt, map_h5::String = "map_data.h5"; map_info::String   = "Map", map_mask::BitArray = falses(1,1),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = save_map(map_map, map_xx, map_yy, map_alt, map_h5, varargin)
    out = [];
% TODO(Julia->MATLAB): map_info::String   = "Map",
% TODO(Julia->MATLAB): map_mask::BitArray = falses(1,1),
% TODO(Julia->MATLAB): map_border::Matrix = zeros(eltype(map_alt),1,1),
% TODO(Julia->MATLAB): map_units::Symbol  = :rad,
% TODO(Julia->MATLAB): file_units::Symbol = :deg)

    map_h5 = add_extension(map_h5,".h5")

    map_xx = vec(map_xx)
    map_yy = vec(map_yy)

% TODO(Julia->MATLAB): if (map_units == :rad) & (file_units == :deg)
        map_xx     = rad2deg(map_xx)
        map_yy     = rad2deg(map_yy)
        map_border = rad2deg(map_border)
% TODO(Julia->MATLAB): elseif (map_units == :deg) & (file_units == :rad)
        map_xx     = deg2rad(map_xx)
        map_yy     = deg2rad(map_yy)
        map_border = deg2rad(map_border)
    elseif map_units ~= file_units
% TODO(Julia->MATLAB): error("[$map_units] map xx/yy units ≠ [$file_units] map file xx/yy units")
% TODO(Julia->MATLAB): elseif map_units ∉ [:rad,:deg]
% TODO(Julia->MATLAB): @info("[$map_units] map xx/yy units not defined")
    end
end
