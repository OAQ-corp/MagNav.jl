% Auto-generated from src/map_fft.jl
% Original Julia signature: function vector_fft(map_map::Matrix, dx, dy, D, I)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [Bx, By, Bz] = vector_fft(map_map, dx, dy, D, I)
    Bx = [];
    (ny,nx) = size(map_map)
    (s,u,v) = create_k(dx,dy,nx,ny)

    l = cos(I)*cos(D)
    m = cos(I)*sin(D)
    n = sin(I)

    F = fft(map_map)

    Hx = im*u ./ (im*(u*l+m*v)+n*s)
    Hy = im*v ./ (im*(u*l+m*v)+n*s)
    Hz = s    ./ (im*(u*l+m*v)+n*s)

    Hx(1,1) = 1
    Hy(1,1) = 1
    Hz(1,1) = 1

    Bx = real(ifft(Hx.*F))
    By = real(ifft(Hy.*F))
    Bz = real(ifft(Hz.*F))

% return (Bx, By, Bz)
end % function vector_fft
end
