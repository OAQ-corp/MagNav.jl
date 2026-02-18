% Auto-generated from src/map_fft.jl
% Original Julia signature: function psd(map_map::Matrix, dx, dy)
% Mechanical conversion draft: review before production use.
function [map_psd, kx, ky] = psd(map_map, dx, dy)
    (ny,nx)   = size(map_map)
    (_,kx,ky) = create_k(dx,dy,nx,ny)
    map_psd   = abs.(fft(map_map)).^2
end % function psd
end
