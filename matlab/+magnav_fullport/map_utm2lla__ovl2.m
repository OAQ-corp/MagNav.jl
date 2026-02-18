% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_utm2lla(mapS::Union{MapS,MapSd,MapS3D}; zone_utm::Int  = 18, is_north::Bool = true, save_h5::Bool  = false, map_h5::String = "map_data.h5")
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function mapS = map_utm2lla__ovl2(mapS, MapSd, MapS3D_, varargin)
    mapS = [];
% TODO(Julia->MATLAB): zone_utm::Int  = 18,
% TODO(Julia->MATLAB): is_north::Bool = true,
% TODO(Julia->MATLAB): save_h5::Bool  = false,
% TODO(Julia->MATLAB): map_h5::String = "map_data.h5")
    mapS = deepcopy(mapS)
% TODO(Julia->MATLAB): map_utm2lla!(mapS;
                 zone_utm = zone_utm,
                 is_north = is_north,
                 save_h5  = save_h5,
                 map_h5   = map_h5)
% return (mapS)
end % function map_utm2lla
end
