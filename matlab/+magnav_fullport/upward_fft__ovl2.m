% Auto-generated from src/map_fft.jl
% Original Julia signature: function upward_fft(map_map::Map, alt; expand::Bool = true, α = 0)
% Mechanical conversion draft: review before production use.
function out = upward_fft__ovl2(map_map, alt, varargin)

    N_alt = length(alt)

    if N_alt > 1
        assert map_map isa Union{MapS,MapS3D} "multiple upward continuation altitudes only allowed for MapS or MapS3D"
        alt = sort(alt)
    end
end
