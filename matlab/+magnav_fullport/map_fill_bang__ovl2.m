% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_fill!(mapS::Union{MapS,MapSd,MapS3D}; k::Int = 3)
% Mechanical conversion draft: review before production use.
function out = map_fill_bang__ovl2(mapS, MapSd, MapS3D_, varargin)
    if mapS isa MapS
        map_fill!(mapS.map,mapS.xx,mapS.yy;k=k)
    elseif mapS isa MapSd
        map_fill!(mapS.map,mapS.xx,mapS.yy;k=k)
        map_fill!(mapS.alt,mapS.xx,mapS.yy;k=k)
    elseif mapS isa MapS3D
        for i in axes(mapS.map,3)
            mapS.map[:,:,i] = map_fill(mapS.map[:,:,i],mapS.xx,mapS.yy;k=k)
        end
end
