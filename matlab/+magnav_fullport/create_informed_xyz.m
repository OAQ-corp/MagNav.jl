% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function create_informed_xyz(xyz::XYZ, ind, mapS::Union{MapS,MapSd,MapS3D}, use_mag::Symbol, use_vec::Symbol, TL_coef::Vector; terms::Vector{Symbol} = [:permanent,:induced,:eddy], disp_min = 100, disp_max = 500, Bt_disp  = 50, Bt_scale = 50000)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function xyz_disp = create_informed_xyz(xyz, ind, mapS, MapSd, MapS3D_, use_mag, use_vec, TL_coef, varargin)
    xyz_disp = [];
% TODO(Julia->MATLAB): use_mag::Symbol, use_vec::Symbol, TL_coef::Vector;
% TODO(Julia->MATLAB): terms::Vector{Symbol} = [:permanent,:induced,:eddy],
                             disp_min = 100,
                             disp_max = 500,
                             Bt_disp  = 50,
                             Bt_scale = 50000)

% TODO(Julia->MATLAB): assert any([:permanent,:p,:permanent3,:p3] .∈ (terms,)) "permanent terms are required"
% TODO(Julia->MATLAB): assert any([:induced,:i,:induced6,:i6,:induced5,:i5,:induced3,:i3] .∈ (terms,)) "induced terms are required"
% TODO(Julia->MATLAB): assert any([:eddy,:e,:eddy9,:e9,:eddy8,:e8,:eddy3,:e3] .∈ (terms,)) "eddy current terms are required"
% TODO(Julia->MATLAB): assert !any([:fdm,:f,:fdm3,:f3,:bias,:b] .∈ (terms,)) "derivative & bias terms may not be used"

    N = length(TL_coef)
    A_test = create_TL_A([1.0],[1.0],[1.0];terms=terms)
    assert N == length(A_test) "TL_coef does not agree with specified terms"

    traj = get_traj(xyz,ind)

    assert map_check(mapS,traj) "trajectory must be inside the provided map"

    % map values along trajectory & map
    (map_val,itp_mapS) = get_map_val(mapS,traj;α=200,return_itp=true)

    % compute vector aircraft component & vector flux along trajectory
    set_igrf = false
    (TL_aircraft,B_earth) =
        calculate_imputed_TL_earth(xyz,ind,map_val,set_igrf,TL_coef,
                                   terms    = terms,
                                   Bt_scale = Bt_scale)

    % sample ~100 points along trajectory
    spacing = floor(Int, traj.N / 100)
% TODO(Julia->MATLAB): pts     = 1:spacing:traj.N

    % average lat & lon points on trajectory & map
    traj_avg = mean([traj.lat(pts),traj.lon(pts)])
    map_avg  = mean([mapS.yy,mapS.xx])

    % average y/x gradients [nT/rad] of sampled points
    grad_avg = mean(map((y,x) -> collect(gradient(itp_mapS,y,x)),
                    traj.lat(pts),traj.lon(pts)))
    dir_disp = normalize(grad_avg)

    % switch direction to go toward middle of map if necessary
% TODO(Julia->MATLAB): (dot(map_avg - traj_avg, dir_disp) < 0) && (dir_disp *= -1)

    % convert displacement limits from [m] to [rad]
    disp_min = min(dn2dlat(disp_min,traj_avg(1)),
                   de2dlon(disp_min,traj_avg(1)))
    disp_max = max(dn2dlat(disp_max,traj_avg(1)),
                   de2dlon(disp_max,traj_avg(1)))

    % shoot for difference of Bt_disp [nT]
    dir_diriv = abs(dot(grad_avg,dir_disp)) % [nT/rad]
    disp_rad  = Bt_disp / dir_diriv % [rad]
    disp_rad  = clamp(disp_rad,disp_min,disp_max) % limit displacement range
    disp_ll   = disp_rad * dir_disp % set correct direction

    % copy & displace trajectory (uniformally; no acceleration changes!)
    xyz_disp = deepcopy(xyz)
% TODO(Julia->MATLAB): xyz_disp.traj.lat(ind) .+= disp_ll(1)
% TODO(Julia->MATLAB): xyz_disp.traj.lon(ind) .+= disp_ll(2)

    assert map_check(mapS,xyz_disp.traj(ind)) "larger map needed, could not create trajectory"

    % map values along trajectory
    map_val_disp = get_map_val(mapS,xyz_disp.traj(ind);α=200)

    % calculate Earth's vector flux & TL component from that on new trajectory
    set_igrf = true
    (TL_aircraft_disp,B_earth_disp) =
        calculate_imputed_TL_earth(xyz_disp,ind,map_val_disp,set_igrf,TL_coef,
                                   terms    = terms,
                                   Bt_scale = Bt_scale)

    % calculate Earth-induced field that would occur along this trajectory
    ΔB_TL    = TL_aircraft_disp - TL_aircraft % known part from aircraft
    ΔB_earth = B_earth_disp     - B_earth     % known part from Earth
% TODO(Julia->MATLAB): ΔB       = ΔB_TL + ΔB_earth % total difference in vector field from different Earth locale & aircraft
% TODO(Julia->MATLAB): Δmap_val = map_val_disp - map_val % differnece in map values

% TODO(Julia->MATLAB): % update displaced vector magnetometer values used in learning
    flux = getfield(xyz_disp,use_vec)
% TODO(Julia->MATLAB): flux.x(ind) += ΔB(1,:)
% TODO(Julia->MATLAB): flux.y(ind) += ΔB(2,:)
% TODO(Julia->MATLAB): flux.z(ind) += ΔB(3,:)
    flux.t(ind)  = sqrt(flux.x(ind).^2 .+ flux.y(ind).^2 .+ flux.z(ind).^2)

% TODO(Julia->MATLAB): % update displaced scalar magnetometer values used in learning
% TODO(Julia->MATLAB): ΔB_dot = dot(eachcol(ΔB),[[x,y,z] for (x,y,z) in
                  zip(flux.x(ind),flux.y(ind),flux.z(ind))]) ./ flux.t(ind)

% TODO(Julia->MATLAB): getfield(xyz_disp,use_mag )[ind] += ΔB_dot
% TODO(Julia->MATLAB): getfield(xyz_disp,:mag_1_c)[ind] += Δmap_val

% return (xyz_disp)
end % function create_informed_xyz
end
