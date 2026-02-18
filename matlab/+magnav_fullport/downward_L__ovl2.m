% Auto-generated from src/map_fft.jl
% Original Julia signature: function downward_L(mapS::Union{MapS,MapSd,MapS3D}, alt, α::Vector; expand::Bool = true)
% Mechanical conversion draft: review before production use.
function out = downward_L__ovl2(mapS, MapSd, MapS3D_, alt, f__, varargin)
                    expand::Bool = true)
    dx   = dlon2de(get_step(mapS.xx),mean(mapS.yy))
    dy   = dlat2dn(get_step(mapS.yy),mean(mapS.yy))
    alt_ = mapS isa Union{MapSd} ? median(mapS.alt[mapS.mask]) : mapS.alt[1]
    dz   = alt - alt_
    mapS isa MapS3D && @info("3D map provided, using map at lowest altitude")
                      map_mask = mapS.mask[:,:,1],
                      expand   = expand)
end % function downward_L
end
