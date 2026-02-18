% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_utm2lla!(map_map::Matrix, map_xx::Vector, map_yy::Vector, alt, map_mask::BitMatrix; map_info::String = "Map", zone_utm::Int    = 18, is_north::Bool   = true, save_h5::Bool    = false, map_h5::String   = "map_data.h5")
% Mechanical conversion draft: review before production use.
function out = map_utm2lla_bang(map_map, map_xx, map_yy, alt, map_mask, varargin)
                      alt, map_mask::BitMatrix;
                      map_info::String = "Map",
                      zone_utm::Int    = 18,
                      is_north::Bool   = true,
                      save_h5::Bool    = false,
                      map_h5::String   = "map_data.h5")

    ind1    = map_params(map_map,map_xx,map_yy)[2]
    (ny,nx) = size(map_map)
    map_drp = (ny,nx) == size(alt) ? true : false

    % interpolation for original (UTM) map
    itp_ind1 = map_itp(convert.(eltype(map_map),ind1),map_xx,map_yy,:linear)
    itp_map  = map_itp(map_map,map_xx,map_yy,:linear)
    itp_mask = map_itp(convert.(eltype(map_map),map_mask),map_xx,map_yy,:linear)
    map_drp && (itp_alt = map_itp(alt,map_xx,map_yy,:linear))

    % get xx/yy limits at 4 corners of data-containing UTM map for no data loss
    (lons,lats) = map_lla_lim(map_xx,map_yy;
                              zone_utm = zone_utm,
                              is_north = is_north)

    % use interior 2 lons/lats as xx/yy limits for new (LLA) map (stay in range)
    δ = 1e-10 % ad hoc to solve rounding related error
    map_xx .= [LinRange(lons[2]+δ,lons[3]-δ,nx);]
    map_yy .= [LinRange(lats[2]+δ,lats[3]-δ,ny);]

    % interpolate original (UTM) map with grid for new (LLA) map
    lla2utm = UTMfromLLA(zone_utm,is_north,WGS84)
    for i = 1:nx, j = 1:ny
        utm = lla2utm(LLA(map_yy[j],map_xx[i]))
        if itp_ind1(utm.y,utm.x) ≈ 1
            @inbounds map_map[ j,i] = itp_map(utm.y,utm.x)
            @inbounds map_mask[j,i] = floor(itp_mask(utm.y,utm.x))
            map_drp && (@inbounds alt[j,i] = itp_alt(utm.y,utm.x))
        else
            @inbounds map_map[ j,i] = 0
            @inbounds map_mask[j,i] = false
            map_drp && (@inbounds alt[j,i] = 0)
        end
end
