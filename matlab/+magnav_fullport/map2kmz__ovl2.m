% Auto-generated from src/google_earth.jl
% Original Julia signature: function map2kmz(mapS::Union{MapS,MapSd,MapS3D}, map_kmz::String = "map.kmz"; use_mask::Bool  = true, plot_alt::Real  = 0, opacity::Real   = 0.75, clims::Tuple    = ())
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function nothing = map2kmz__ovl2(mapS, MapSd, MapS3D_, map_kmz, varargin)
    nothing = [];
% TODO(Julia->MATLAB): map_kmz::String = "map.kmz";
% TODO(Julia->MATLAB): use_mask::Bool  = true,
% TODO(Julia->MATLAB): plot_alt::Real  = 0,
% TODO(Julia->MATLAB): opacity::Real   = 0.75,
% TODO(Julia->MATLAB): clims::Tuple    = ())
% TODO(Julia->MATLAB): mapS isa MapS3D && @info("3D map provided, using map at lowest altitude")
    map_mask = use_mask ? mapS.mask(:,:,1) : trues(size(mapS.map(:,:,1)))
    map2kmz(mapS.map(:,:,1).*map_mask,mapS.xx,mapS.yy,map_kmz;
% TODO(Julia->MATLAB): map_units = :rad,
            plot_alt  = plot_alt,
            opacity   = opacity,
            clims     = clims)
% return ([])
end % function map2kmz
end
