% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_map!(p1::Plot, map_map::Matrix, map_xx::Vector       = [], map_yy::Vector       = []; clims::Tuple         = (),
% Mechanical conversion draft: review before production use.
function out = plot_map_bang(p1, map_map, map_xx, map_yy, varargin)
                   map_xx::Vector       = [],
                   map_yy::Vector       = [];
                   clims::Tuple         = (),
                   dpi::Int             = 200,
                   margin::Int          = 2,
                   Nmax::Int            = 6*dpi,
                   legend::Bool         = true,
                   axis::Bool           = true,
                   map_color::Symbol    = :usgs,
                   bg_color::Symbol     = :white,
                   map_units::Symbol    = :rad,
                   plot_units::Symbol   = :deg,
                   b_e::AbstractBackend = gr())

    (ny,nx) = size(map_map)
    xx_mid  = ceil(Int,nx/2)
    yy_mid  = ceil(Int,ny/2)

    % avoid modifying original data (possibly in map struct)
    map_map = float.(map_map)
    map_xx  = length(map_xx) < nx ? float.([1:nx;]) : float.(map_xx)
    map_yy  = length(map_yy) < ny ? float.([1:ny;]) : float.(map_yy)

    if map_units == :rad
        if plot_units == :deg
            map_xx .= rad2deg.(map_xx)
            map_yy .= rad2deg.(map_yy)
        elseif plot_units == :m % longitude inaccuracy scales with map size
            lon_mid = map_xx[xx_mid]
            lat_mid = map_yy[yy_mid]
            map_xx .= dlon2de.(map_xx .- lon_mid, lat_mid)
            map_yy .= dlat2dn.(map_yy .- lat_mid, map_yy)
        end
end
