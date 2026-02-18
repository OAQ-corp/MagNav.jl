% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_border(map_map::Matrix, map_xx::Vector, map_yy::Vector; inner::Bool       = true, sort_border::Bool = false, return_ind::Bool  = false)
% Mechanical conversion draft: review before production use.
function out = map_border(map_map, map_xx, map_yy, varargin)
                    inner::Bool       = true,
                    sort_border::Bool = false,
                    return_ind::Bool  = false)

    (ind0_,ind1_,nx,ny) = map_params(map_map)
    (Ny,Nx) = (ny,nx) .+ 2
    ind     = falses(Ny,Nx)
    ind0    = trues( Ny,Nx)
    ind1    = falses(Ny,Nx)
    ind0[2:Ny-1,2:Nx-1] = ind0_
    ind1[2:Ny-1,2:Nx-1] = ind1_

    % non-empty point along left/right edge of original map area
    for i in [2,Nx-1]
        for j = 2:Ny-1
            ind[j,i] = ind1[j,i]
        end
end
