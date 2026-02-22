% Auto-generated from src/model_functions.jl
% Original Julia signature: function igrf_grad(lat, lon, alt; date = get_years(2020,185), δ = 1.0f-8)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [alt, lon] = igrf_grad(lat, lon, alt, varargin)
    alt = [];
    dlat = dlon = δ
    dalt = dlat2dn(δ,lat)
% TODO(Julia->MATLAB): return ([(norm(igrf(date,alt,lat+dlat,lon,Val(:geodetic))) -
% TODO(Julia->MATLAB): norm(igrf(date,alt,lat-dlat,lon,Val(:geodetic)))) /2/dlat,
% TODO(Julia->MATLAB): (norm(igrf(date,alt,lat,lon+dlon,Val(:geodetic))) -
% TODO(Julia->MATLAB): norm(igrf(date,alt,lat,lon-dlon,Val(:geodetic)))) /2/dlon,
% TODO(Julia->MATLAB): (norm(igrf(date,alt+dalt,lat,lon,Val(:geodetic))) -
% TODO(Julia->MATLAB): norm(igrf(date,alt-dalt,lat,lon,Val(:geodetic)))) /2/dalt])
end % function igrf_grad
end
