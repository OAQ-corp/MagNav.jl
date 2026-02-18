% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_resample(mapS::MapS, map_xx_new::Vector, map_yy_new::Vector)
% Mechanical conversion draft: review before production use.
function out = map_resample__ovl2(mapS, map_xx_new, map_yy_new)
    (map_map,map_mask) = map_resample(mapS.map,mapS.xx,mapS.yy,
                                      mapS.mask,map_xx_new,map_yy_new)
end % function map_resample
end
