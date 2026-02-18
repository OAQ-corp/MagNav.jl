% Auto-generated from src/map_functions.jl
% Original Julia signature: function get_map_val(map_map_vec::Vector, path::Path, ind = trues(path.N); α = 200)
% Mechanical conversion draft: review before production use.
function out = get_map_val__ovl3(map_map_vec, path, ind, varargin)
    [get_map_val(map_map_vec[i],path,ind;
                 α=α,return_itp=false) for i in eachindex(map_map_vec)]
end % function get_map_val
end
