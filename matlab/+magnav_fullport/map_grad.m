% Auto-generated from src/model_functions.jl
% Original Julia signature: function map_grad(itp_mapS, lat, lon, alt; δ = 1.0f-8)
% Mechanical conversion draft: review before production use.
function [lon, alt] = map_grad(itp_mapS, lat, lon, alt, varargin)
    dlat = dlon = δ
    dalt = dlat2dn(δ,lat)
             (itp_mapS(lat,lon+dlon,alt) - itp_mapS(lat,lon-dlon,alt)) /2/dlon,
             (itp_mapS(lat,lon,alt+dalt) - itp_mapS(lat,lon,alt-dalt)) /2/dalt])
end % function map_grad
end
