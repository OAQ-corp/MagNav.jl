% Auto-generated from src/map_functions.jl
% Original Julia signature: function get_map_val(map_map::Map, path::Path, ind = trues(path.N);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_map_val__ovl2(map_map, path, ind)
    out = [];
% TODO(Julia->MATLAB): α=200, return_itp::Bool = false)
    get_map_val(map_map,path.lat(ind),path.lon(ind),path.alt(ind);α=α,return_itp=return_itp)
end % function get_map_val
end
