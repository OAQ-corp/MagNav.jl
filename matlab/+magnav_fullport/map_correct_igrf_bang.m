% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_correct_igrf!(map_map::Matrix, map_alt, map_xx::Vector, map_yy::Vector; sub_igrf_date::Real = get_years(2013,293),
% Mechanical conversion draft: review before production use.
function out = map_correct_igrf_bang(map_map, map_alt, map_xx, map_yy, varargin)
                           map_xx::Vector, map_yy::Vector;
                           sub_igrf_date::Real = get_years(2013,293),
                           add_igrf_date::Real = -1,
                           zone_utm::Int       = 18,
                           is_north::Bool      = true,
                           map_units::Symbol   = :rad)

    (_,ind1,nx,ny) = map_params(map_map,map_xx,map_yy)

    all(map_alt .< 0)    && (map_alt = 300) % in case -1 map_gxf2h5() default provided
    length(map_alt) == 1 && (map_alt = fill(map_alt,size(map_map))) % in case single altitude provided
    map_alt = convert.(eltype(map_map),map_alt)

    sub_igrf = sub_igrf_date > 0 ? true : false
    add_igrf = add_igrf_date > 0 ? true : false

    if sub_igrf | add_igrf

        utm2lla = LLAfromUTM(zone_utm,is_north,WGS84)

        @info("starting igrf")

        for i = 1:nx, j = 1:ny % time consumer
            if ind1[j,i]

                if map_units == :utm
                    lla = utm2lla(UTM(map_xx[i],map_yy[j],map_alt[j,i]))
                elseif map_units == :rad
                    lla = LLA(rad2deg(map_yy[j]),rad2deg(map_xx[i]),map_alt[j,i])
                elseif map_units == :deg
                    lla = LLA(map_yy[j],map_xx[i],map_alt[j,i])
                else
                    error("[$map_units] map xx/yy units not defined")
                end
end
