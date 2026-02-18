% Auto-generated from src/map_fft.jl
% Original Julia signature: function psd(map_map::Matrix, dx, dy)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [map_psd, kx, ky] = psd(map_map, dx, dy)
    map_psd = [];
    (ny,nx)   = size(map_map)
    (_,kx,ky) = create_k(dx,dy,nx,ny)
    map_psd   = abs(fft(map_map)).^2
% return (map_psd, kx, ky)
end % function psd
end
