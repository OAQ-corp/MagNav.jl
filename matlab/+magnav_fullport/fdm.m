% Auto-generated from src/tolles_lawson.jl
% Original Julia signature: function fdm(x::Vector; scheme::Symbol = :central)
% Mechanical conversion draft: review before production use.
function out = fdm(x, varargin)

    N = length(x)

    if (scheme == :backward) & (N > 1)
        dif_1   =  x[2]       - x[1]
        dif_end =  x[end]     - x[end-1]
        dif_mid = (x[2:end-1] - x[1:end-2])
    elseif (scheme == :forward) & (N > 1)
        dif_1   =  x[2]       - x[1]
        dif_end =  x[end]     - x[end-1]
        dif_mid = (x[3:end] - x[2:end-1])
    elseif (scheme in [:central,:central2]) & (N > 2)
        dif_1   =  x[2]     - x[1]
        dif_end =  x[end]   - x[end-1]
        dif_mid = (x[3:end] - x[1:end-2]) ./ 2
    elseif (scheme == :backward2) & (N > 3)
        dif_1   = x[2:3]     - x[1:2]
        dif_end = (3*x[end]     - 4*x[end-1]   + x[end-2]    ) ./ 2
        dif_mid = (3*x[3:end-1] - 4*x[2:end-2] + x[1:end-3]  ) ./ 2
    elseif (scheme == :forward2) & (N > 3)
        dif_1   = (-x[3]        + 4*x[2]       - 3*x[1]      ) ./ 2
        dif_end = x[end-1:end] - x[end-2:end-1]
        dif_mid = (-x[4:end]    + 4*x[3:end-1] - 3*x[2:end-2]) ./ 2
    elseif (scheme in [:fourth,:central4]) & (N > 4)
        dif_1   = zeros(eltype(x),2)
        dif_end = zeros(eltype(x),2)
        dif_mid = (   x[1:end-4] +
                   -4*x[2:end-3] +
                    6*x[3:end-2] +
                   -4*x[4:end-1] +
                      x[5:end  ] ) ./ 16 % divided by dx^4
    else
    end
end
