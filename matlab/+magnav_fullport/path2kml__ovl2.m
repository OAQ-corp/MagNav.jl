% Auto-generated from src/google_earth.jl
% Original Julia signature: function path2kml(path::Path, path_kml::String = "path.kml"; width::Int       = 3, color1::String   = "", color2::String   = "00ffffff", points::Bool     = false)
% Mechanical conversion draft: review before production use.
function out = path2kml__ovl2(path, path_kml, varargin)
                  path_kml::String = "path.kml";
                  width::Int       = 3,
                  color1::String   = "",
                  color2::String   = "00ffffff",
                  points::Bool     = false)

    if isempty(color1)
        path isa Traj    && (color1 = "ffff8500")
        path isa INS     && (color1 = "ff2b50ec")
        path isa FILTout && (color1 = "ff319b00")
    end
end
