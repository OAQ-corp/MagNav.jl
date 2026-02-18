% Auto-generated from src/map_fft.jl
% Original Julia signature: function downward_L(mapS::Union{MapS,MapSd,MapS3D}, alt, α::Vector; expand::Bool = true)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = downward_L__ovl2(mapS, MapSd, MapS3D_, alt, f__, varargin)
    out = [];
% TODO(Julia->MATLAB): expand::Bool = true)
    dx   = dlon2de(get_step(mapS.xx),mean(mapS.yy))
    dy   = dlat2dn(get_step(mapS.yy),mean(mapS.yy))
    alt_ = mapS isa Union{MapSd} ? median(mapS.alt(mapS.mask)) : mapS.alt(1)
    dz   = alt - alt_
% TODO(Julia->MATLAB): mapS isa MapS3D && @info("3D map provided, using map at lowest altitude")
% return downward_L(mapS.map(:,:,1),dx,dy,dz,α;
                      map_mask = mapS.mask(:,:,1),
                      expand   = expand)
end % function downward_L
end
