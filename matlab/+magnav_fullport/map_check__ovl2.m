% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_check(map_map::Map, path::Path, ind = trues(path.N))
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_check__ovl2(map_map, path, ind)
    out = [];
    map_check(map_map,path.lat(ind),path.lon(ind),path.alt(ind))
end % function map_check
end
