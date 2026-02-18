% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_correct_igrf!(mapS::Union{MapS,MapSd,MapS3D}; sub_igrf_date::Real = get_years(2013,293),
% Mechanical conversion draft: review before production use.
function out = map_correct_igrf_bang__ovl2(mapS, MapSd, MapS3D_, varargin)
                           sub_igrf_date::Real = get_years(2013,293),
                           add_igrf_date::Real = -1,
                           zone_utm::Int       = 18,
                           is_north::Bool      = true,
                           map_units::Symbol   = :rad)
    if mapS isa Union{MapS,MapSd}
        map_correct_igrf!(mapS.map,mapS.alt,mapS.xx,mapS.yy;
                          sub_igrf_date = sub_igrf_date,
                          add_igrf_date = add_igrf_date,
                          zone_utm      = zone_utm,
                          is_north      = is_north,
                          map_units     = map_units)
    elseif mapS isa MapS3D
        for i in eachindex(mapS.alt)
            mapS.map[:,:,i] = map_correct_igrf(mapS.map[:,:,i],mapS.alt[i],
                                               mapS.xx,mapS.yy;
                                               sub_igrf_date = sub_igrf_date,
                                               add_igrf_date = add_igrf_date,
                                               zone_utm      = zone_utm,
                                               is_north      = is_north,
                                               map_units     = map_units)
        end
end
