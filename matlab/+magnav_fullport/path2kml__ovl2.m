% Auto-generated from src/google_earth.jl
% Original Julia signature: function path2kml(path::Path, path_kml::String = "path.kml"; width::Int       = 3, color1::String   = "", color2::String   = "00ffffff", points::Bool     = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = path2kml__ovl2(path, path_kml, varargin)
    out = [];
% TODO(Julia->MATLAB): path_kml::String = "path.kml";
% TODO(Julia->MATLAB): width::Int       = 3,
% TODO(Julia->MATLAB): color1::String   = "",
% TODO(Julia->MATLAB): color2::String   = "00ffffff",
% TODO(Julia->MATLAB): points::Bool     = false)

    if isempty(color1)
        path isa Traj    && (color1 = "ffff8500")
        path isa INS     && (color1 = "ff2b50ec")
        path isa FILTout && (color1 = "ff319b00")
    end
end
