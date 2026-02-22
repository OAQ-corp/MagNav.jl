% Auto-generated from src/model_functions.jl
% Original Julia signature: function get_H(itp_mapS, x::Vector, lat, lon, alt; date       = get_years(2020,185),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_H(itp_mapS, x, lat, lon, alt, varargin)
    out = [];
               date       = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool = false)
    if core
% return ([(igrf_grad(lat+x(1),lon+x(2),alt+x(3);date=date) +
% TODO(Julia->MATLAB): map_grad(itp_mapS,lat+x(1),lon+x(2),alt+x(3))); zero(x)[4:end-1]; 1])
    else
% TODO(Julia->MATLAB): return ([map_grad(itp_mapS,lat+x(1),lon+x(2),alt+x(3)) ; zero(x)[4:end-1]; 1])
    end
end
