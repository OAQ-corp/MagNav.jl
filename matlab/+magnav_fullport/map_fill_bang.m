% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_fill!(map_map::Matrix, map_xx::Vector, map_yy::Vector; k::Int = 3)
% Mechanical conversion draft: review before production use.
function out = map_fill_bang(map_map, map_xx, map_yy, varargin)

    (ind0,ind1,nx,ny) = map_params(map_map,map_xx,map_yy)

    data = vcat(vec(repeat(map_xx',ny,1)[ind1])',
                vec(repeat(map_yy ,1,nx)[ind1])') % xx & yy at ind1 [2 x N1]
    pts  = vcat(vec(repeat(map_xx',ny,1)[ind0])',
                vec(repeat(map_yy ,1,nx)[ind0])') % xx & yy at ind0 [2 x N0]
    vals = vec(map_map[ind1]) % map data at ind1 [N1]
    tree = KDTree(float.(data))
    inds = knn(tree,pts,k,true)[1]

    j = 0
    for i in eachindex(map_map)
        if ind0[i]
            j += 1
            @inbounds map_map[i] = mean(vals[inds[j]])
        end
end
