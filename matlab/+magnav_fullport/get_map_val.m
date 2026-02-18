% Auto-generated from src/map_functions.jl
% Original Julia signature: function get_map_val(map_map::Map, lat, lon, alt; α = 200, return_itp::Bool = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_map_val(map_map, lat, lon, alt, varargin)
    out = [];
    if map_map isa MapS
        all(map_map.alt .> 0) && (map_map = upward_fft(map_map,median(alt);α=α))
        itp_map = map_itp(map_map)
        map_val = itp_map(lat,lon)
    elseif map_map isa MapSd
        itp_map = map_itp(map_map)
        map_val = itp_map(lat,lon)
    elseif map_map isa MapS3D
        alt_min = map_map.alt(1)
        alt_max = map_map.alt(end)
        dalt    = get_step(map_map.alt)
        while minimum(alt) < alt_min
% TODO(Julia->MATLAB): alt_min -= dalt
        end
end
