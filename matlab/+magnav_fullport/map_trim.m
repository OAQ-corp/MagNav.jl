% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_trim(map_map::Matrix, map_xx::Vector    = collect(axes(map_map,2)),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_trim(map_map, map_xx, f_2_)
    out = [];
% TODO(Julia->MATLAB): map_xx::Vector    = collect(axes(map_map,2)),
% TODO(Julia->MATLAB): map_yy::Vector    = collect(axes(map_map,1));
% TODO(Julia->MATLAB): pad::Int          = 0,
% TODO(Julia->MATLAB): xx_lim::Tuple     = (-Inf,Inf),
% TODO(Julia->MATLAB): yy_lim::Tuple     = (-Inf,Inf),
% TODO(Julia->MATLAB): zone_utm::Int     = 18,
% TODO(Julia->MATLAB): is_north::Bool    = true,
% TODO(Julia->MATLAB): map_units::Symbol = :rad,
% TODO(Julia->MATLAB): silent::Bool      = true)

    (ny,nx) = size(map_map)

    % xx limits of data-containing map
    xx_sum  = vec(sum(map_map,dims=1))
    xx_1    = findfirst(xx_sum .~= 0)
    xx_nx   = findlast(xx_sum  .~= 0)

    % yy limits of data-containing map
    yy_sum = vec(sum(map_map,dims=2))
    yy_1   = findfirst(yy_sum .~= 0)
    yy_ny  = findlast(yy_sum  .~= 0)

    % (optional) user-specified limits
    xx_lim = extrema(findall((map_xx .> minimum(xx_lim)) .&
                             (map_xx .< maximum(xx_lim))))
    yy_lim = extrema(findall((map_yy .> minimum(yy_lim)) .&
                             (map_yy .< maximum(yy_lim))))

    % smallest possible data-containing & user-specified map
    xx_1   = maximum([xx_1 ,xx_lim(1)])
    xx_nx  = minimum([xx_nx,xx_lim(2)])
    yy_1   = maximum([yy_1 ,yy_lim(1)])
    yy_ny  = minimum([yy_ny,yy_lim(2)])

% TODO(Julia->MATLAB): if map_units == :utm

        % get xx/yy limits at 4 corners of data-containing UTM map for no data loss
        (lons,lats) = map_lla_lim(map_xx,map_yy;
                                  xx_1     = xx_1,
                                  xx_nx    = xx_nx,
                                  yy_1     = yy_1,
                                  yy_ny    = yy_ny,
                                  zone_utm = zone_utm,
                                  is_north = is_north)

        % use EXTERIOR 2 lons/lats as xx/yy limits
        lla2utm = UTMfromLLA(zone_utm,is_north,WGS84)
        utms    = lla2utm(LLA(lats([1,1,end,end)],lons([1,end,1,end)]))

        % xx/yy limits at 4 corners of UTM map for no data loss
        % due to Earth's curvature, xx/yy limits are further out
% TODO(Julia->MATLAB): xxs = sort([utm.x for utm in utms])
% TODO(Julia->MATLAB): yys = sort([utm.y for utm in utms])

% TODO(Julia->MATLAB): elseif map_units in [:rad,:deg]

        % directly use data-containing xx/yy limits at 4 corners
        xxs = sort(map_xx([xx_1,xx_1,xx_nx,xx_nx)])
        yys = sort(map_yy([yy_1,yy_1,yy_ny,yy_ny)])

    else
% TODO(Julia->MATLAB): error("[$map_units] map xx/yy units not defined")

    end
end
