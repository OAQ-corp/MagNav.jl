% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_correct_igrf(mapS::Union{MapS,MapSd,MapS3D}; sub_igrf_date::Real = get_years(2013,293),
% Mechanical conversion draft: review before production use.
function mapS = map_correct_igrf__ovl2(mapS, MapSd, MapS3D_, varargin)
                          sub_igrf_date::Real = get_years(2013,293),
                          add_igrf_date::Real = -1,
                          zone_utm::Int       = 18,
                          is_north::Bool      = true,
                          map_units::Symbol   = :rad)
    mapS = deepcopy(mapS)
    map_correct_igrf!(mapS;
                      sub_igrf_date = sub_igrf_date,
                      add_igrf_date = add_igrf_date,
                      zone_utm      = zone_utm,
                      is_north      = is_north,
                      map_units     = map_units)
end % function map_correct_igrf
end
