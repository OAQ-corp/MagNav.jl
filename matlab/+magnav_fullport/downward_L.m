% Auto-generated from src/map_fft.jl
% Original Julia signature: function downward_L(map_map::Matrix, dx, dy, dz, α::Vector; map_mask::BitMatrix = map_params(map_map)[2],
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = downward_L(map_map, dx, dy, dz, f__, varargin)
    out = [];
% TODO(Julia->MATLAB): map_mask::BitMatrix = map_params(map_map)[2],
% TODO(Julia->MATLAB): expand::Bool        = true)

    (ny,nx) = size(map_map)
    norms   = zeros(eltype(map_map),length(α)-1)

    if expand
        pad = min(maximum(ceil(Int,10*abs(dz)./(dx,dy))),5000) % set pad > 10*dz
        (map_map,px,py) = map_expand(map_map,pad)     % expand with pad
        (Ny,Nx) = size(map_map)
    else
        (Ny,Nx,px,py) = (ny,nx,0,0)
    end
end
