% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_clims(c, map_map::Matrix)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_clims(c, map_map)
    out = [];

    lc = length(c) % length of original color scale
    map_mask = abs(map_map) .>= 1e-3 % mask for approximately non-zero map data

    if length(unique(map_map(map_mask))) > lc
        indc  = round(Int,LinRange(0.5,lc-0.5,lc)/lc*sum(map_mask)) % bin indices
% TODO(Julia->MATLAB): bcen  = sort(map_map(map_mask))[indc] % bin centers
        bwid  = fdm(bcen) % bin widths
        nc    = round(Int,bwid/minimum(bwid)) % times to repeat each color
% TODO(Julia->MATLAB): c     = cgrad([c(i) for i = 1:lc for j = 1:nc(i)]) % new color scale
        clims = (bcen(1) - bwid(1)/2, bcen(end) + bwid(end)/2) % colorbar limits
    else
        clims = extrema(map_map)
    end
end
