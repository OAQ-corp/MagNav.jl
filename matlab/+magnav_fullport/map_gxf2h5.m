% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_gxf2h5(map_gxf::String, alt_gxf::String, alt::Real; map_info::String    = splitpath(map_gxf)[end],
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_gxf2h5(map_gxf, alt_gxf, alt, varargin)
    out = [];
% TODO(Julia->MATLAB): map_info::String    = splitpath(map_gxf)[end],
% TODO(Julia->MATLAB): pad::Int            = 0,
% TODO(Julia->MATLAB): sub_igrf_date::Real = get_years(2013,293),
% TODO(Julia->MATLAB): add_igrf_date::Real = -1,
% TODO(Julia->MATLAB): zone_utm::Int       = 18,
% TODO(Julia->MATLAB): is_north::Bool      = true,
% TODO(Julia->MATLAB): fill_map::Bool      = true,
% TODO(Julia->MATLAB): up_cont::Bool       = true,
% TODO(Julia->MATLAB): down_cont::Bool     = true,
% TODO(Julia->MATLAB): get_lla::Bool       = true,
% TODO(Julia->MATLAB): dz::Real            = 5,
% TODO(Julia->MATLAB): down_max::Real      = 150,
% TODO(Julia->MATLAB): α::Real             = 200,
% TODO(Julia->MATLAB): save_h5::Bool       = false,
% TODO(Julia->MATLAB): map_h5::String      = "map_data.h5")

    @info("starting GXF read")

    % get raw map data
    (map_map,map_xx ,map_yy ) = map_get_gxf(map_gxf)
    (map_alt,map_xx_,map_yy_) = map_get_gxf(alt_gxf)

    % make sure grids match
% TODO(Julia->MATLAB): assert (map_xx ≈ map_xx_) & (map_yy ≈ map_yy_) "grids do not match"

    @info("starting trim")

    % trim away large areas that are missing map data
    (ind_xx,ind_yy) = map_trim(map_map,map_xx,map_yy;
                               pad       = pad,
                               zone_utm  = zone_utm,
                               is_north  = is_north,
% TODO(Julia->MATLAB): map_units = :utm,
                               silent    = false)
    map_xx  = map_xx(ind_xx)
    map_yy  = map_yy(ind_yy)
    map_map = map_map(ind_yy,ind_xx)
    map_alt = map_alt(ind_yy,ind_xx)

% TODO(Julia->MATLAB): map_mask = map_params(map_map,map_xx,map_yy)[2]

    % subtract and/or add IGRF to map data
% TODO(Julia->MATLAB): map_correct_igrf!(map_map,map_alt,map_xx,map_yy;
                      sub_igrf_date = sub_igrf_date,
                      add_igrf_date = add_igrf_date,
                      zone_utm      = zone_utm,
                      is_north      = is_north,
% TODO(Julia->MATLAB): map_units     = :utm)

    if fill_map % fill remaining areas that are missing map data
        @info("starting fill")
% TODO(Julia->MATLAB): map_fill!(map_map,map_xx,map_yy)
% TODO(Julia->MATLAB): map_fill!(map_alt,map_xx,map_yy)
    end
end
