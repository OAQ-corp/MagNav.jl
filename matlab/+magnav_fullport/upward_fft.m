% Auto-generated from src/map_fft.jl
% Original Julia signature: function upward_fft(map_map::Matrix, dx, dy, dz; expand::Bool = true, α = 0)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = upward_fft(map_map, dx, dy, dz, varargin)
    out = [];

    (ny,nx) = size(map_map)

    if expand
        pad = min(maximum(ceil(Int,10*maximum(abs(dz))./(dx,dy))),5000) % set pad > 10*dz
        (map_,px,py) = map_expand(map_map,pad) % expand with pad
        (Ny,Nx) = size(map_)
    else
        map_ = map_map
        (Ny,Nx,px,py) = (ny,nx,0,0)
    end
end
