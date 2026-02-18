% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_fill(map_map::Matrix, map_xx::Vector, map_yy::Vector; k::Int = 3)
% Mechanical conversion draft: review before production use.
function map_map = map_fill(map_map, map_xx, map_yy, varargin)
    map_map = deepcopy(map_map)
    map_fill!(map_map,map_xx,map_yy;k=k)
end % function map_fill
end
