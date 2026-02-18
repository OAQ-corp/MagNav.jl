% Auto-generated from src/model_functions.jl
% Original Julia signature: function igrf_grad(lat, lon, alt; date = get_years(2020,185), δ = 1.0f-8)
% Mechanical conversion draft: review before production use.
function [alt, lon] = igrf_grad(lat, lon, alt, varargin)
    dlat = dlon = δ
    dalt = dlat2dn(δ,lat)
              norm(igrf(date,alt,lat-dlat,lon,Val(:geodetic)))) /2/dlat,
             (norm(igrf(date,alt,lat,lon+dlon,Val(:geodetic))) -
              norm(igrf(date,alt,lat,lon-dlon,Val(:geodetic)))) /2/dlon,
             (norm(igrf(date,alt+dalt,lat,lon,Val(:geodetic))) -
              norm(igrf(date,alt-dalt,lat,lon,Val(:geodetic)))) /2/dalt])
end % function igrf_grad
end
