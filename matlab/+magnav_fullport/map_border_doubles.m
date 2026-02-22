% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_border_doubles(ind::BitMatrix)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_border_doubles(ind)
    out = [];
    ind_    = ind
    (Ny,Nx) = size(ind) .+ 2
    ind     = falses(Ny,Nx)
% TODO(Julia->MATLAB): ind(2:Ny-1,2:Nx-1) = deepcopy(ind_)
    sum_ind = 0
    while sum_ind ~= sum(ind)
        sum_ind = sum(ind)
% TODO(Julia->MATLAB): for i = 3:Nx-1
% TODO(Julia->MATLAB): for j = 3:Ny-1
                if ind(j,i)
% TODO(Julia->MATLAB): if all(ind(j-1:j,i))
% TODO(Julia->MATLAB): ind(j-1:j,i) = sum(ind(j-1:j,i-1)+ind([j-2,j+1),i]) > 0
                    end
end
