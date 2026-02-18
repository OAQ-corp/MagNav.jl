% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_combine(mapS::MapS, mapS_fallback::MapS = get_map(namad);
% Mechanical conversion draft: review before production use.
function out = map_combine(mapS, mapS_fallback)
                     map_info::String = mapS.info,
                     xx_lim::Tuple    = get_lim(mapS.xx,0.1),
                     yy_lim::Tuple    = get_lim(mapS.yy,0.1),
                     α                = 200)

    % map setup
    mapS = map_trim(mapS)
    (map_xx,ind_xx) = expand_range(mapS.xx,xx_lim)
    (map_yy,ind_yy) = expand_range(mapS.yy,yy_lim)

    % fallback map setup
    assert clamp.(extrema(mapS_fallback.xx),xx_lim...) == xx_lim "xx_lim are outside mapS_fallback xx limits"
    assert clamp.(extrema(mapS_fallback.yy),yy_lim...) == yy_lim "yy_lim are outside mapS_fallback yy limits"
    mapS_fallback = upward_fft(mapS_fallback,mapS.alt;α=α)
    mapS_fallback = map_trim(mapS_fallback;pad=1,
                             xx_lim=extrema(map_xx),yy_lim=extrema(map_yy))
    itp_mapS = map_itp(mapS_fallback)

    (lat,lon,ind) = map_border(mapS;
                               inner       = true,
                               sort_border = false,
                               return_ind  = true)
    mapS.map[ind] = (mapS.map[ind] + itp_mapS.(lat,lon)) / 2

    map_map  = zeros(eltype(mapS.map ),length.((map_yy,map_xx)))
    map_mask = falses(size(map_map))
    map_map[ ind_yy,ind_xx] = mapS.map .* mapS.mask
    map_mask[ind_yy,ind_xx] = mapS.mask
    (ind0,_,nx,ny) = map_params(map_map)
    for i = 1:nx, j = 1:ny
        ind0[j,i] && (map_map[j,i] = itp_mapS(map_yy[j],map_xx[i]))
    end
end
