% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_interpolate(mapV::MapV, dim::Symbol = :X, type::Symbol = :cubic)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_interpolate__ovl3(mapV, dim, type)
    out = [];

% TODO(Julia->MATLAB): if dim == :X
        map_itp(mapV.mapX,mapV.xx,mapV.yy,type)
% TODO(Julia->MATLAB): elseif dim == :Y
        map_itp(mapV.mapY,mapV.xx,mapV.yy,type)
% TODO(Julia->MATLAB): elseif dim == :Z
        map_itp(mapV.mapZ,mapV.xx,mapV.yy,type)
    else
% TODO(Julia->MATLAB): error("$dim dim not defined")
    end
end
