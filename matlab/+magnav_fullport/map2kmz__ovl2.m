% Auto-generated from src/google_earth.jl
% Original Julia signature: function map2kmz(mapS::Union{MapS,MapSd,MapS3D}, map_kmz::String = "map.kmz"; use_mask::Bool  = true, plot_alt::Real  = 0, opacity::Real   = 0.75, clims::Tuple    = ())
% Mechanical conversion draft: review before production use.
function nothing = map2kmz__ovl2(mapS, MapSd, MapS3D_, map_kmz, varargin)
                 map_kmz::String = "map.kmz";
                 use_mask::Bool  = true,
                 plot_alt::Real  = 0,
                 opacity::Real   = 0.75,
                 clims::Tuple    = ())
    mapS isa MapS3D && @info("3D map provided, using map at lowest altitude")
    map_mask = use_mask ? mapS.mask[:,:,1] : trues(size(mapS.map[:,:,1]))
    map2kmz(mapS.map[:,:,1].*map_mask,mapS.xx,mapS.yy,map_kmz;
            map_units = :rad,
            plot_alt  = plot_alt,
            opacity   = opacity,
            clims     = clims)
end % function map2kmz
end
