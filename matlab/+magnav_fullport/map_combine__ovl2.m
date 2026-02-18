% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_combine(mapS_vec::Vector, mapS_fallback::MapS = get_map(namad);
% Mechanical conversion draft: review before production use.
function out = map_combine__ovl2(mapS_vec, mapS_fallback)
                     map_info::String   = "Combined map",
                     N_levels::Int      = 3,
                     dx                 = get_step(mapS_vec[1].xx),
                     dy                 = get_step(mapS_vec[1].yy),
                     xx_lim::Tuple      = get_lim(mapS_vec[1].xx,0.5),
                     yy_lim::Tuple      = get_lim(mapS_vec[1].yy,0.5),
                     α                  = 200,
                     use_fallback::Bool = true)

    assert all(isa.(mapS_vec,MapS)) "only MapS allowed"

    % sort maps by altitude
    mapS_alt = [mapS.alt for mapS in mapS_vec]
    mapS_vec = mapS_vec[sortperm(mapS_alt)]
    mapS_alt = [mapS.alt for mapS in mapS_vec]
    alt_lev  = [LinRange(mapS_alt[1],mapS_alt[end],N_levels);]

    % resample grids to match
    map_xx   = [xx_lim[1]:dx:xx_lim[2]+dx-eps(float(xx_lim[2]));]
    map_yy   = [yy_lim[1]:dy:yy_lim[2]+dy-eps(float(yy_lim[2]));]
    mapS_vec = [map_resample(mapS,map_xx,map_yy) for mapS in mapS_vec]

    if use_fallback % fill with fallback map
        mapS_vec = [map_combine(mapS,mapS_fallback;
                    xx_lim=xx_lim,yy_lim=yy_lim,α=α) for mapS in mapS_vec]
    else % fill with knn
        mapS_vec = [map_fill(mapS) for mapS in mapS_vec]
    end
end
