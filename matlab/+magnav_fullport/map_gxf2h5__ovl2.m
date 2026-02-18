% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_gxf2h5(map_gxf::String, alt::Real; map_info::String = splitpath(map_gxf)[end],
% Mechanical conversion draft: review before production use.
function out = map_gxf2h5__ovl2(map_gxf, alt, varargin)
                    map_info::String = splitpath(map_gxf)[end],
                    fill_map::Bool   = true,
                    get_lla::Bool    = true,
                    zone_utm::Int    = 18,
                    is_north::Bool   = true,
                    save_h5::Bool    = false,
                    map_h5::String   = "map_data.h5")

    (map_map,map_xx,map_yy) = map_get_gxf(map_gxf) % get raw map data

    % trim away large areas that are missing map data
    (ind_xx,ind_yy) = map_trim(map_map,map_xx,map_yy;
                               pad       = 0,
                               zone_utm  = zone_utm,
                               is_north  = is_north,
                               map_units = :utm,
                               silent    = true)
    map_xx  = map_xx[ind_xx]
    map_yy  = map_yy[ind_yy]
    map_map = map_map[ind_yy,ind_xx]

    map_mask = map_params(map_map,map_xx,map_yy)[2]

    % fill remaining areas that are missing map data
    fill_map && map_fill!(map_map,map_xx,map_yy)

    if get_lla % convert map grid from UTM to LLA
        map_utm2lla!(map_map,map_xx,map_yy,alt,map_mask;
                     map_info = map_info,
                     zone_utm = zone_utm,
                     is_north = is_north,
                     save_h5  = save_h5,
                     map_h5   = map_h5)
    elseif save_h5
        save_map(map_map,map_xx,map_yy,alt,map_h5;
                 map_info=map_info,map_mask=map_mask,
                 map_units=:utm,file_units=:utm)
    end
end
