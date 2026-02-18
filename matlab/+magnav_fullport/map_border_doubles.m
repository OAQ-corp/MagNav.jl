% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_border_doubles(ind::BitMatrix)
% Mechanical conversion draft: review before production use.
function out = map_border_doubles(ind)
    ind_    = ind
    (Ny,Nx) = size(ind) .+ 2
    ind     = falses(Ny,Nx)
    ind[2:Ny-1,2:Nx-1] = deepcopy(ind_)
    sum_ind = 0
    while sum_ind ~= sum(ind)
        sum_ind = sum(ind)
        for i = 3:Nx-1
            for j = 3:Ny-1
                if ind[j,i]
                    if all(ind[j-1:j,i])
                        ind[j-1:j,i] .= sum(ind[j-1:j,i-1]+ind[[j-2,j+1],i]) > 0
                    end
end
