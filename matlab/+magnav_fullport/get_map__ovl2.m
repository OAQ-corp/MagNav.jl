% Auto-generated from src/get_map.jl
% Original Julia signature: function get_map(map_name::Symbol, df_map::DataFrame, map_field::Symbol  = :map_data; map_info::String   = "$map_name", map_units::Symbol  = :rad, file_units::Symbol = :deg, flip_map::Bool     = false)
% Mechanical conversion draft: review before production use.
function out = get_map__ovl2(map_name, df_map, map_field, varargin)
                 map_field::Symbol  = :map_data;
                 map_info::String   = "$map_name",
                 map_units::Symbol  = :rad,
                 file_units::Symbol = :deg,
                 flip_map::Bool     = false)
    ind = findfirst(Symbol.(df_map.map_name) .== map_name)
    get_map(String(df_map.map_file[ind]),map_field;
            map_info   = map_info,
            map_units  = map_units,
            file_units = file_units,
            flip_map   = flip_map)
end % function get_map
end
