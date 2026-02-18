% Auto-generated from src/model_functions.jl
% Original Julia signature: function get_H(itp_mapS, x::Vector, lat, lon, alt; date       = get_years(2020,185),
% Mechanical conversion draft: review before production use.
function out = get_H(itp_mapS, x, lat, lon, alt, varargin)
               date       = get_years(2020,185),
               core::Bool = false)
    if core
                 map_grad(itp_mapS,lat+x[1],lon+x[2],alt+x[3])); zero(x)[4:end-1]; 1])
    else
    end
end
