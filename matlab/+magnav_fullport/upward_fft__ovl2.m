% Auto-generated from src/map_fft.jl
% Original Julia signature: function upward_fft(map_map::Map, alt; expand::Bool = true, α = 0)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = upward_fft__ovl2(map_map, alt, varargin)
    out = [];

    N_alt = length(alt)

    if N_alt > 1
        assert map_map isa Union{MapS,MapS3D} "multiple upward continuation altitudes only allowed for MapS or MapS3D"
        alt = sort(alt)
    end
end
