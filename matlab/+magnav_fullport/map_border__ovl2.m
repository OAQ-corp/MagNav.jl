% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_border(mapS::Union{MapS,MapSd,MapS3D}; inner::Bool       = true, sort_border::Bool = false, return_ind::Bool  = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_border__ovl2(mapS, MapSd, MapS3D_, varargin)
    out = [];
% TODO(Julia->MATLAB): inner::Bool       = true,
% TODO(Julia->MATLAB): sort_border::Bool = false,
% TODO(Julia->MATLAB): return_ind::Bool  = false)
% TODO(Julia->MATLAB): mapS isa MapS3D && @info("3D map provided, using map at lowest altitude")
    map_border(mapS.map(:,:,1).*mapS.mask(:,:,1),mapS.xx,mapS.yy;
               inner=inner,sort_border=sort_border,return_ind=return_ind)
end % function map_border
end
