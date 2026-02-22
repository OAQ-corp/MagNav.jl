% Auto-generated from src/map_functions.jl
% Original Julia signature: function get_cached_map(map_cache::Map_Cache, lat::Real, lon::Real, alt::Real; silent::Bool = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_cached_map(map_cache, lat, lon, alt, varargin)
    out = [];
% TODO(Julia->MATLAB): silent::Bool = false)
    alt_lev = -1  % initialize
    o = map_cache % convenience

    try
% TODO(Julia->MATLAB): for (i,ind) in enumerate(o.map_sort_ind)
            if (o.maps(ind).alt <= alt) & map_check(o.maps(ind),lat,lon)
                alt_lev = max(floor(alt/o.dz)*o.dz, o.maps(ind).alt)
                if (i, alt_lev) ∉ keys(o.map_cache)
% TODO(Julia->MATLAB): silent || @info("generating cached map at $alt_lev m")
                    mapS     = upward_fft(o.maps(ind),alt_lev)
                    itp_mapS = map_itp(mapS)
                    o.map_cache((i,alt_lev)) = itp_mapS
                else
                    itp_mapS = o.map_cache((i,alt_lev))
                end
end
