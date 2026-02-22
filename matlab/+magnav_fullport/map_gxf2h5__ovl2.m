% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_gxf2h5(map_gxf::String, alt::Real; map_info::String = splitpath(map_gxf)[end],
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_gxf2h5__ovl2(map_gxf, alt, varargin)
    out = [];
% TODO(Julia->MATLAB): map_info::String = splitpath(map_gxf)[end],
% TODO(Julia->MATLAB): fill_map::Bool   = true,
% TODO(Julia->MATLAB): get_lla::Bool    = true,
% TODO(Julia->MATLAB): zone_utm::Int    = 18,
% TODO(Julia->MATLAB): is_north::Bool   = true,
% TODO(Julia->MATLAB): save_h5::Bool    = false,
% TODO(Julia->MATLAB): map_h5::String   = "map_data.h5")

    (map_map,map_xx,map_yy) = map_get_gxf(map_gxf) % get raw map data

    % trim away large areas that are missing map data
    (ind_xx,ind_yy) = map_trim(map_map,map_xx,map_yy;
                               pad       = 0,
                               zone_utm  = zone_utm,
                               is_north  = is_north,
% TODO(Julia->MATLAB): map_units = :utm,
                               silent    = true)
    map_xx  = map_xx(ind_xx)
    map_yy  = map_yy(ind_yy)
    map_map = map_map(ind_yy,ind_xx)

% TODO(Julia->MATLAB): map_mask = map_params(map_map,map_xx,map_yy)[2]

    % fill remaining areas that are missing map data
% TODO(Julia->MATLAB): fill_map && map_fill!(map_map,map_xx,map_yy)

    if get_lla % convert map grid from UTM to LLA
% TODO(Julia->MATLAB): map_utm2lla!(map_map,map_xx,map_yy,alt,map_mask;
                     map_info = map_info,
                     zone_utm = zone_utm,
                     is_north = is_north,
                     save_h5  = save_h5,
                     map_h5   = map_h5)
    elseif save_h5
        save_map(map_map,map_xx,map_yy,alt,map_h5;
                 map_info=map_info,map_mask=map_mask,
% TODO(Julia->MATLAB): map_units=:utm,file_units=:utm)
    end
end
