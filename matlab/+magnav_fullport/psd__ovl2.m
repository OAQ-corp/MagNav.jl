% Auto-generated from src/map_fft.jl
% Original Julia signature: function psd(mapS::Union{MapS,MapSd,MapS3D})
% Mechanical conversion draft: review before production use.
function out = psd__ovl2(mapS, MapSd, MapS3D_)
    dx = dlon2de(get_step(mapS.xx),mean(mapS.yy))
    dy = dlat2dn(get_step(mapS.yy),mean(mapS.yy))
    mapS isa MapS3D && @info("3D map provided, using map at lowest altitude")
end % function psd
end
