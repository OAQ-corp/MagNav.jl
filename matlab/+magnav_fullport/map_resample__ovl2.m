% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_resample(mapS::MapS, map_xx_new::Vector, map_yy_new::Vector)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_resample__ovl2(mapS, map_xx_new, map_yy_new)
    out = [];
    (map_map,map_mask) = map_resample(mapS.map,mapS.xx,mapS.yy,
                                      mapS.mask,map_xx_new,map_yy_new)
% return MapS(mapS.info, map_map, map_xx_new, map_yy_new, mapS.alt, map_mask)
end % function map_resample
end
