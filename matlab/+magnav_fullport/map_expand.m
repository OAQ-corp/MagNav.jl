% Auto-generated from src/map_fft.jl
% Original Julia signature: function map_expand(map_map::Matrix, pad::Int = 1)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_expand(map_map, pad)
    out = [];

    map_ = float(map_map)

    (ny,nx) = size(map_) % original map size
    (Ny,Nx) = smooth7((ny,nx).+2*pad) % map size with 7-smooth padding
    % (Ny,Nx) = (ny,nx).+ 2*pad % map size with naive padding

    % padding on each edge
    padx = (floor(Int,(Nx-nx)/2),ceil(Int,(Nx-nx)/2))
    pady = (floor(Int,(Ny-ny)/2),ceil(Int,(Ny-ny)/2))

% TODO(Julia->MATLAB): % place original map in middle of new map
    (x1,x2) = (1,nx) .+ padx(1)
    (y1,y2) = (1,ny) .+ pady(1)
    map_map = zeros(eltype(map_),Ny,Nx)
% TODO(Julia->MATLAB): map_map(y1:y2,x1:x2) = map_

    % fill row edges (right/left)
% TODO(Julia->MATLAB): for j = y1:y2
% TODO(Julia->MATLAB): vals = LinRange(map_map(j,x1),map_map(j,x2),Nx-nx+2)[2:end-1]
% TODO(Julia->MATLAB): map_map(j,1:x1-1  ) = reverse(vals(1:padx[1)])
% TODO(Julia->MATLAB): map_map(j,x2+1:end) = reverse(vals((1:padx[2)).+padx(1)])
    end
end
