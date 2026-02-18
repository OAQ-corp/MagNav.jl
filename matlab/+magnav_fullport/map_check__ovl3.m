% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_check(map_map_vec::Vector, path::Path, ind = trues(path.N))
% Mechanical conversion draft: review before production use.
function out = map_check__ovl3(map_map_vec, path, ind)
    [map_check(map_map_vec[i],path,ind) for i in eachindex(map_map_vec)]
end % function map_check
end
