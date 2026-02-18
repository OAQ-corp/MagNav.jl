% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_correct_igrf(map_map::Matrix, map_alt, map_xx::Vector, map_yy::Vector; sub_igrf_date::Real = get_years(2013,293),
% Mechanical conversion draft: review before production use.
function map_map = map_correct_igrf(map_map, map_alt, map_xx, map_yy, varargin)
                          map_xx::Vector, map_yy::Vector;
                          sub_igrf_date::Real = get_years(2013,293),
                          add_igrf_date::Real = -1,
                          zone_utm::Int       = 18,
                          is_north::Bool      = true,
                          map_units::Symbol   = :rad)
    map_map = float.(map_map)
    map_correct_igrf!(map_map,map_alt,map_xx,map_yy;
                      sub_igrf_date = sub_igrf_date,
                      add_igrf_date = add_igrf_date,
                      zone_utm      = zone_utm,
                      is_north      = is_north,
                      map_units     = map_units)
end % function map_correct_igrf
end
