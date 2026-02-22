% Auto-generated from src/google_earth.jl
% Original Julia signature: function map2kmz(map_map::Matrix, map_xx::Vector, map_yy::Vector, map_kmz::String   = "map.kmz"; map_units::Symbol = :rad, plot_alt::Real    = 0, opacity::Real     = 0.75, clims::Tuple      = ())
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map2kmz(map_map, map_xx, map_yy, map_kmz, varargin)
    out = [];
% TODO(Julia->MATLAB): map_kmz::String   = "map.kmz";
% TODO(Julia->MATLAB): map_units::Symbol = :rad,
% TODO(Julia->MATLAB): plot_alt::Real    = 0,
% TODO(Julia->MATLAB): opacity::Real     = 0.75,
% TODO(Julia->MATLAB): clims::Tuple      = ())

% TODO(Julia->MATLAB): if map_units == :rad
        map_west  = rad2deg(minimum(map_xx))
        map_east  = rad2deg(maximum(map_xx))
        map_south = rad2deg(minimum(map_yy))
        map_north = rad2deg(maximum(map_yy))
% TODO(Julia->MATLAB): elseif map_units == :deg
        map_west  = minimum(map_xx)
        map_east  = maximum(map_xx)
        map_south = minimum(map_yy)
        map_north = maximum(map_yy)
    else
% TODO(Julia->MATLAB): error("[$map_units] map xx/yy units not defined")
    end
end
