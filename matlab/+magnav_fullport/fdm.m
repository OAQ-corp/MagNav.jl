% Auto-generated from src/tolles_lawson.jl
% Original Julia signature: function fdm(x::Vector; scheme::Symbol = :central)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = fdm(x, varargin)
    out = [];

    N = length(x)

% TODO(Julia->MATLAB): if (scheme == :backward) & (N > 1)
        dif_1   =  x(2)       - x(1)
        dif_end =  x(end)     - x(end-1)
% TODO(Julia->MATLAB): dif_mid = (x(2:end-1) - x(1:end-2))
% TODO(Julia->MATLAB): elseif (scheme == :forward) & (N > 1)
        dif_1   =  x(2)       - x(1)
        dif_end =  x(end)     - x(end-1)
% TODO(Julia->MATLAB): dif_mid = (x(3:end) - x(2:end-1))
% TODO(Julia->MATLAB): elseif (scheme in [:central,:central2]) & (N > 2)
        dif_1   =  x(2)     - x(1)
        dif_end =  x(end)   - x(end-1)
% TODO(Julia->MATLAB): dif_mid = (x(3:end) - x(1:end-2)) ./ 2
% TODO(Julia->MATLAB): elseif (scheme == :backward2) & (N > 3)
        dif_1   = x(2:3)     - x(1:2)
        dif_end = (3*x(end)     - 4*x(end-1)   + x(end-2)    ) ./ 2
% TODO(Julia->MATLAB): dif_mid = (3*x(3:end-1) - 4*x(2:end-2) + x(1:end-3)  ) ./ 2
% TODO(Julia->MATLAB): elseif (scheme == :forward2) & (N > 3)
        dif_1   = (-x(3)        + 4*x(2)       - 3*x(1)      ) ./ 2
% TODO(Julia->MATLAB): dif_end = x(end-1:end) - x(end-2:end-1)
% TODO(Julia->MATLAB): dif_mid = (-x(4:end)    + 4*x(3:end-1) - 3*x(2:end-2)) ./ 2
% TODO(Julia->MATLAB): elseif (scheme in [:fourth,:central4]) & (N > 4)
        dif_1   = zeros(eltype(x),2)
        dif_end = zeros(eltype(x),2)
% TODO(Julia->MATLAB): dif_mid = (   x(1:end-4) +
% TODO(Julia->MATLAB): -4*x(2:end-3) +
% TODO(Julia->MATLAB): 6*x(3:end-2) +
% TODO(Julia->MATLAB): -4*x(4:end-1) +
% TODO(Julia->MATLAB): x(5:end  ) ) ./ 16 % divided by dx^4
    else
% return zero(x)
    end
end
