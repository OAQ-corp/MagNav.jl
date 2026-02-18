% Auto-generated from src/google_earth.jl
% Original Julia signature: function map2kmz(map_map::Matrix, map_xx::Vector, map_yy::Vector, map_kmz::String   = "map.kmz"; map_units::Symbol = :rad, plot_alt::Real    = 0, opacity::Real     = 0.75, clims::Tuple      = ())
% Mechanical conversion draft: review before production use.
function out = map2kmz(map_map, map_xx, map_yy, map_kmz, varargin)
                 map_kmz::String   = "map.kmz";
                 map_units::Symbol = :rad,
                 plot_alt::Real    = 0,
                 opacity::Real     = 0.75,
                 clims::Tuple      = ())

    if map_units == :rad
        map_west  = rad2deg(minimum(map_xx))
        map_east  = rad2deg(maximum(map_xx))
        map_south = rad2deg(minimum(map_yy))
        map_north = rad2deg(maximum(map_yy))
    elseif map_units == :deg
        map_west  = minimum(map_xx)
        map_east  = maximum(map_xx)
        map_south = minimum(map_yy)
        map_north = maximum(map_yy)
    else
        error("[$map_units] map xx/yy units not defined")
    end
end
