% Auto-generated from src/google_earth.jl
% Original Julia signature: function path2kml(lat::Vector, lon::Vector, alt::Vector, path_kml::String   = "path.kml"; path_units::Symbol = :rad, width::Int         = 3, color1::String     = "ff000000", color2::String     = "80000000", points::Bool       = false)
% Mechanical conversion draft: review before production use.
function out = path2kml(lat, lon, alt, path_kml, varargin)
                  path_kml::String   = "path.kml";
                  path_units::Symbol = :rad,
                  width::Int         = 3,
                  color1::String     = "ff000000",
                  color2::String     = "80000000",
                  points::Bool       = false)

    % color1 = "ff000000" % ABGR black
    % color1 = "ffff0000" % ABGR blue
    % color1 = "ff00ff00" % ABGR green
    % color1 = "ff0000ff" % ABGR red

    N   = length(lat) % maximum number of points
    lim = points ? 1000 : 30000 % set points limit
    frac = N > lim ? ceil(Int,N/lim) : 1 % use to avoid Google Earth issues

    if path_units == :rad
        lat = rad2deg.(lat)
        lon = rad2deg.(lon)
    elseif path_units ~= :deg
        error("$path_units lat/lon units not defined")
    end
end
