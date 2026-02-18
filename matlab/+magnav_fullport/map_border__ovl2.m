% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_border(mapS::Union{MapS,MapSd,MapS3D}; inner::Bool       = true, sort_border::Bool = false, return_ind::Bool  = false)
% Mechanical conversion draft: review before production use.
function out = map_border__ovl2(mapS, MapSd, MapS3D_, varargin)
                    inner::Bool       = true,
                    sort_border::Bool = false,
                    return_ind::Bool  = false)
    mapS isa MapS3D && @info("3D map provided, using map at lowest altitude")
    map_border(mapS.map[:,:,1].*mapS.mask[:,:,1],mapS.xx,mapS.yy;
               inner=inner,sort_border=sort_border,return_ind=return_ind)
end % function map_border
end
