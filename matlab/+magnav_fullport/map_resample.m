% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_resample(map_map::Matrix, map_xx::Vector, map_yy::Vector, map_mask::BitMatrix, map_xx_new::Vector, map_yy_new::Vector)
% Mechanical conversion draft: review before production use.
function out = map_resample(map_map, map_xx, map_yy, map_mask, map_xx_new, map_yy_new)
                      map_mask::BitMatrix, map_xx_new::Vector, map_yy_new::Vector)

    map_map_  = float.(map_map)
    map_mask_ = true .* map_mask
    (map_xx,ind_xx) = expand_range(map_xx,extrema(map_xx_new),true)
    (map_yy,ind_yy) = expand_range(map_yy,extrema(map_yy_new),true)
    map_map   = zeros(eltype(map_map ),length.((map_yy,map_xx)))
    map_mask  = falses(size(map_map))
    map_map[ ind_yy,ind_xx] = map_map_
    map_mask[ind_yy,ind_xx] = map_mask_

    ind1     = map_params(map_map,map_xx,map_yy)[2]
    itp_ind1 = map_itp(convert.(eltype(map_map),ind1),map_xx,map_yy,:linear)
    itp_map  = map_itp(map_map,map_xx,map_yy,:linear)
    itp_mask = map_itp(convert.(eltype(map_map),map_mask),map_xx,map_yy,:linear)
    map_map  = zeros(eltype(map_map ),length.((map_yy_new,map_xx_new)))
    map_mask = falses(size(map_map))

    for (i,x) in enumerate(map_xx_new)
        for (j,y) in enumerate(map_yy_new)
                if itp_ind1(y,x) ≈ 1
                    @inbounds map_map[ j,i] = itp_map(y,x)
                    @inbounds map_mask[j,i] = floor(itp_mask(y,x))
                end
end
