% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_interpolate(mapV::MapV, dim::Symbol = :X, type::Symbol = :cubic)
% Mechanical conversion draft: review before production use.
function out = map_interpolate__ovl3(mapV, dim, type)

    if dim == :X
        map_itp(mapV.mapX,mapV.xx,mapV.yy,type)
    elseif dim == :Y
        map_itp(mapV.mapY,mapV.xx,mapV.yy,type)
    elseif dim == :Z
        map_itp(mapV.mapZ,mapV.xx,mapV.yy,type)
    else
        error("$dim dim not defined")
    end
end
