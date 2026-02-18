% Auto-generated from src/model_functions.jl
% Original Julia signature: function get_h(itp_mapS, der_mapS, x::Array, lat, lon, alt, map_alt; date       = get_years(2020,185),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_h__ovl2(itp_mapS, der_mapS, x, lat, lon, alt, map_alt, varargin)
    out = [];
               date       = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool = false)

    map_val = itp_mapS(lat.+x(1,:),lon.+x(2,:),alt.+x(3,:))
    der_val = der_mapS(lat.+x(1,:),lon.+x(2,:),alt.+x(3,:))

    if core
% return (map_val .+ x(end,:) .+ der_val .* (alt.+x(3,:) .- map_alt) .+
% TODO(Julia->MATLAB): norm(igrf(date,alt.+x(3,:),lat.+x(1,:),lon.+x(2,:),Val(:geodetic))))
    else
% return (map_val .+ x(end,:) .+ der_val .* (alt.+x(3,:) .- map_alt))
    end
end
