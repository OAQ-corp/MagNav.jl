% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_utm2lla!(mapS::Union{MapS,MapSd,MapS3D}; zone_utm::Int  = 18, is_north::Bool = true, save_h5::Bool  = false, map_h5::String = "map_data.h5")
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_utm2lla_bang__ovl2(mapS, MapSd, MapS3D_, varargin)
    out = [];
% TODO(Julia->MATLAB): zone_utm::Int  = 18,
% TODO(Julia->MATLAB): is_north::Bool = true,
% TODO(Julia->MATLAB): save_h5::Bool  = false,
% TODO(Julia->MATLAB): map_h5::String = "map_data.h5")
    if mapS isa Union{MapS,MapSd}
% TODO(Julia->MATLAB): map_utm2lla!(mapS.map,mapS.xx,mapS.yy,mapS.alt,mapS.mask;
                     map_info = mapS.info,
                     zone_utm = zone_utm,
                     is_north = is_north,
                     save_h5  = save_h5,
                     map_h5   = map_h5)
    elseif mapS isa MapS3D
        map_xx_ = float(mapS.xx)
        map_yy_ = float(mapS.yy)
% TODO(Julia->MATLAB): for i in eachindex(mapS.alt)
            (map_map,map_xx,map_yy,map_mask) = map_utm2lla(mapS.map(:,:,i),
                                                           map_xx_,map_yy_,
                                                           mapS.alt(i),
                                                           mapS.mask(:,:,i);
                                                           map_info = mapS.info,
                                                           zone_utm = zone_utm,
                                                           is_north = is_north,
                                                           save_h5  = false)
            mapS.map(:,:,i) = map_map
            mapS.xx = map_xx
            mapS.yy = map_yy
            mapS.mask(:,:,i) = map_mask
        end
end
