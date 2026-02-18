% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_utm2lla(mapS::Union{MapS,MapSd,MapS3D}; zone_utm::Int  = 18, is_north::Bool = true, save_h5::Bool  = false, map_h5::String = "map_data.h5")
% Mechanical conversion draft: review before production use.
function mapS = map_utm2lla__ovl2(mapS, MapSd, MapS3D_, varargin)
                     zone_utm::Int  = 18,
                     is_north::Bool = true,
                     save_h5::Bool  = false,
                     map_h5::String = "map_data.h5")
    mapS = deepcopy(mapS)
    map_utm2lla!(mapS;
                 zone_utm = zone_utm,
                 is_north = is_north,
                 save_h5  = save_h5,
                 map_h5   = map_h5)
end % function map_utm2lla
end
