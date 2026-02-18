% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_map!(p1::Plot, map_map::Matrix, map_xx::Vector       = [], map_yy::Vector       = []; clims::Tuple         = (),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_map_bang(p1, map_map, map_xx, map_yy, varargin)
    out = [];
% TODO(Julia->MATLAB): map_xx::Vector       = [],
% TODO(Julia->MATLAB): map_yy::Vector       = [];
% TODO(Julia->MATLAB): clims::Tuple         = (),
% TODO(Julia->MATLAB): dpi::Int             = 200,
% TODO(Julia->MATLAB): margin::Int          = 2,
% TODO(Julia->MATLAB): Nmax::Int            = 6*dpi,
% TODO(Julia->MATLAB): legend::Bool         = true,
% TODO(Julia->MATLAB): axis::Bool           = true,
% TODO(Julia->MATLAB): map_color::Symbol    = :usgs,
% TODO(Julia->MATLAB): bg_color::Symbol     = :white,
% TODO(Julia->MATLAB): map_units::Symbol    = :rad,
% TODO(Julia->MATLAB): plot_units::Symbol   = :deg,
% TODO(Julia->MATLAB): b_e::AbstractBackend = gr())

    (ny,nx) = size(map_map)
    xx_mid  = ceil(Int,nx/2)
    yy_mid  = ceil(Int,ny/2)

% TODO(Julia->MATLAB): % avoid modifying original data (possibly in map struct)
    map_map = float(map_map)
% TODO(Julia->MATLAB): map_xx  = length(map_xx) < nx ? float([1:nx;]) : float(map_xx)
% TODO(Julia->MATLAB): map_yy  = length(map_yy) < ny ? float([1:ny;]) : float(map_yy)

% TODO(Julia->MATLAB): if map_units == :rad
% TODO(Julia->MATLAB): if plot_units == :deg
            map_xx = rad2deg(map_xx)
            map_yy = rad2deg(map_yy)
% TODO(Julia->MATLAB): elseif plot_units == :m % longitude inaccuracy scales with map size
            lon_mid = map_xx(xx_mid)
            lat_mid = map_yy(yy_mid)
            map_xx = dlon2de(map_xx .- lon_mid, lat_mid)
            map_yy = dlat2dn(map_yy .- lat_mid, map_yy)
        end
end
