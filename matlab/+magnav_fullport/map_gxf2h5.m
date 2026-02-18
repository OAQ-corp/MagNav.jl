% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_gxf2h5(map_gxf::String, alt_gxf::String, alt::Real; map_info::String    = splitpath(map_gxf)[end],
% Mechanical conversion draft: review before production use.
function out = map_gxf2h5(map_gxf, alt_gxf, alt, varargin)
                    map_info::String    = splitpath(map_gxf)[end],
                    pad::Int            = 0,
                    sub_igrf_date::Real = get_years(2013,293),
                    add_igrf_date::Real = -1,
                    zone_utm::Int       = 18,
                    is_north::Bool      = true,
                    fill_map::Bool      = true,
                    up_cont::Bool       = true,
                    down_cont::Bool     = true,
                    get_lla::Bool       = true,
                    dz::Real            = 5,
                    down_max::Real      = 150,
                    α::Real             = 200,
                    save_h5::Bool       = false,
                    map_h5::String      = "map_data.h5")

    @info("starting GXF read")

    % get raw map data
    (map_map,map_xx ,map_yy ) = map_get_gxf(map_gxf)
    (map_alt,map_xx_,map_yy_) = map_get_gxf(alt_gxf)

    % make sure grids match
    assert (map_xx ≈ map_xx_) & (map_yy ≈ map_yy_) "grids do not match"

    @info("starting trim")

    % trim away large areas that are missing map data
    (ind_xx,ind_yy) = map_trim(map_map,map_xx,map_yy;
                               pad       = pad,
                               zone_utm  = zone_utm,
                               is_north  = is_north,
                               map_units = :utm,
                               silent    = false)
    map_xx  = map_xx[ind_xx]
    map_yy  = map_yy[ind_yy]
    map_map = map_map[ind_yy,ind_xx]
    map_alt = map_alt[ind_yy,ind_xx]

    map_mask = map_params(map_map,map_xx,map_yy)[2]

    % subtract and/or add IGRF to map data
    map_correct_igrf!(map_map,map_alt,map_xx,map_yy;
                      sub_igrf_date = sub_igrf_date,
                      add_igrf_date = add_igrf_date,
                      zone_utm      = zone_utm,
                      is_north      = is_north,
                      map_units     = :utm)

    if fill_map % fill remaining areas that are missing map data
        @info("starting fill")
        map_fill!(map_map,map_xx,map_yy)
        map_fill!(map_alt,map_xx,map_yy)
    end
end
