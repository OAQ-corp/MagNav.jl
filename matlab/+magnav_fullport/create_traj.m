% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function create_traj(mapS::Union{MapS,MapSd,MapS3D} = get_map(namad);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = create_traj(mapS, MapSd, MapS3D_)
    out = [];
                     alt             = 1000,
                     dt              = 0.1,
                     t               = 300,
                     v               = 68,
% TODO(Julia->MATLAB): ll1::Tuple      = (),
% TODO(Julia->MATLAB): ll2::Tuple      = (),
% TODO(Julia->MATLAB): N_waves::Int    = 1,
% TODO(Julia->MATLAB): attempts::Int   = 10,
% TODO(Julia->MATLAB): save_h5::Bool   = false,
% TODO(Julia->MATLAB): traj_h5::String = "traj_data.h5")

    traj_h5 = add_extension(traj_h5,".h5")

    % check flight altitude
    alt_ = mapS isa Union{MapSd} ? median(mapS.alt(mapS.mask)) : mapS.alt(1)
% TODO(Julia->MATLAB): alt  < alt_ && error("flight altitude $alt < map altitude $alt_")

    i   = 0
    N   = 2
    lat = zeros(N)
    lon = zeros(N)
% TODO(Julia->MATLAB): while (!map_check(mapS,lat,lon) & (i <= attempts)) | (i == 0)
% TODO(Julia->MATLAB): i += 1

% TODO(Julia->MATLAB): if isempty(ll1) % put initial point in middle 50% of map
            (lat_min,lat_max) = extrema(mapS.yy)
            (lon_min,lon_max) = extrema(mapS.xx)
            lat1 = lat_min + (lat_max - lat_min) * (0.25 + 0.50*rand())
            lon1 = lon_min + (lon_max - lon_min) * (0.25 + 0.50*rand())
        else % use given initial point
            (lat1,lon1) = deg2rad(ll1)
        end
end
