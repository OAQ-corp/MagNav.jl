% Auto-generated from src/map_fft.jl
% Original Julia signature: function create_k(dx, dy, nx::Int, ny::Int)
% Mechanical conversion draft: review before production use.
function [k, kx, ky] = create_k(dx, dy, nx, ny)
    % DFT sample frequencies [rad/m], 1/dx & 1/dy are sampling rates [1/m]
    kx = nx*dx==0 ? zeros(ny,nx) : repeat(2*pi*fftfreq(nx,1/dx)',ny,1)
    ky = ny*dy==0 ? zeros(ny,nx) : repeat(2*pi*fftfreq(ny,1/dy) ,1,nx)
    k  = sqrt.(kx.^2+ky.^2)
end % function create_k
end
