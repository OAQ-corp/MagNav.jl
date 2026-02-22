% Auto-generated from src/google_earth.jl
% Original Julia signature: function path2kml(lat::Vector, lon::Vector, alt::Vector, path_kml::String   = "path.kml"; path_units::Symbol = :rad, width::Int         = 3, color1::String     = "ff000000", color2::String     = "80000000", points::Bool       = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = path2kml(lat, lon, alt, path_kml, varargin)
    out = [];
% TODO(Julia->MATLAB): path_kml::String   = "path.kml";
% TODO(Julia->MATLAB): path_units::Symbol = :rad,
% TODO(Julia->MATLAB): width::Int         = 3,
% TODO(Julia->MATLAB): color1::String     = "ff000000",
% TODO(Julia->MATLAB): color2::String     = "80000000",
% TODO(Julia->MATLAB): points::Bool       = false)

    % color1 = "ff000000" % ABGR black
    % color1 = "ffff0000" % ABGR blue
    % color1 = "ff00ff00" % ABGR green
    % color1 = "ff0000ff" % ABGR red

    N   = length(lat) % maximum number of points
    lim = points ? 1000 : 30000 % set points limit
    frac = N > lim ? ceil(Int,N/lim) : 1 % use to avoid Google Earth issues

% TODO(Julia->MATLAB): if path_units == :rad
        lat = rad2deg(lat)
        lon = rad2deg(lon)
% TODO(Julia->MATLAB): elseif path_units ~= :deg
% TODO(Julia->MATLAB): error("$path_units lat/lon units not defined")
    end
end
