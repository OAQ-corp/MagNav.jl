% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_fill(mapS::Union{MapS,MapSd,MapS3D}; k::Int = 3)
% Mechanical conversion draft: review before production use.
function mapS = map_fill__ovl2(mapS, MapSd, MapS3D_, varargin)
    mapS = deepcopy(mapS)
    map_fill!(mapS;k=k)
end % function map_fill
end
