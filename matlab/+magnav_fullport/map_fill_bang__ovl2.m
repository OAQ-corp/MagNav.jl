% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_fill!(mapS::Union{MapS,MapSd,MapS3D}; k::Int = 3)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_fill_bang__ovl2(mapS, MapSd, MapS3D_, varargin)
    out = [];
    if mapS isa MapS
% TODO(Julia->MATLAB): map_fill!(mapS.map,mapS.xx,mapS.yy;k=k)
    elseif mapS isa MapSd
% TODO(Julia->MATLAB): map_fill!(mapS.map,mapS.xx,mapS.yy;k=k)
% TODO(Julia->MATLAB): map_fill!(mapS.alt,mapS.xx,mapS.yy;k=k)
    elseif mapS isa MapS3D
% TODO(Julia->MATLAB): for i in axes(mapS.map,3)
            mapS.map(:,:,i) = map_fill(mapS.map(:,:,i),mapS.xx,mapS.yy;k=k)
        end
end
