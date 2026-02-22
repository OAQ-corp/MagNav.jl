% Auto-generated from src/map_fft.jl
% Original Julia signature: function psd(mapS::Union{MapS,MapSd,MapS3D})
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = psd__ovl2(mapS, MapSd, MapS3D_)
    out = [];
    dx = dlon2de(get_step(mapS.xx),mean(mapS.yy))
    dy = dlat2dn(get_step(mapS.yy),mean(mapS.yy))
% TODO(Julia->MATLAB): mapS isa MapS3D && @info("3D map provided, using map at lowest altitude")
% return psd(mapS.map(:,:,1).*mapS.mask(:,:,1), dx, dy)
end % function psd
end
