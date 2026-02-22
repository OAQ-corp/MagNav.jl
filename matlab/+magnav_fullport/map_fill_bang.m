% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_fill!(map_map::Matrix, map_xx::Vector, map_yy::Vector; k::Int = 3)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_fill_bang(map_map, map_xx, map_yy, varargin)
    out = [];

    (ind0,ind1,nx,ny) = map_params(map_map,map_xx,map_yy)

% TODO(Julia->MATLAB): data = vcat(vec(repeat(map_xx',ny,1)[ind1])',
% TODO(Julia->MATLAB): vec(repeat(map_yy ,1,nx)[ind1])') % xx & yy at ind1 [2 x N1]
% TODO(Julia->MATLAB): pts  = vcat(vec(repeat(map_xx',ny,1)[ind0])',
% TODO(Julia->MATLAB): vec(repeat(map_yy ,1,nx)[ind0])') % xx & yy at ind0 [2 x N0]
    vals = vec(map_map(ind1)) % map data at ind1 [N1]
    tree = KDTree(float(data))
% TODO(Julia->MATLAB): inds = knn(tree,pts,k,true)[1]

    j = 0
% TODO(Julia->MATLAB): for i in eachindex(map_map)
        if ind0(i)
% TODO(Julia->MATLAB): j += 1
            @inbounds map_map(i) = mean(vals(inds[j)])
        end
end
