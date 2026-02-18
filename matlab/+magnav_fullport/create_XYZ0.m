% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function create_XYZ0(mapS::Union{MapS,MapSd,MapS3D} = get_map(namad);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = create_XYZ0(mapS, MapSd, MapS3D_)
    out = [];
                     alt            = 1000,
                     dt             = 0.1,
                     t              = 300,
                     v              = 68,
% TODO(Julia->MATLAB): ll1::Tuple     = (), % (0.54, -1.44)
% TODO(Julia->MATLAB): ll2::Tuple     = (), % (0.55, -1.45)
% TODO(Julia->MATLAB): N_waves::Int   = 1,
% TODO(Julia->MATLAB): attempts::Int  = 10,
% TODO(Julia->MATLAB): info::String   = "Simulated data",
                     flight         = 1,
                     line           = 1,
                     year           = 2023,
                     doy            = 154,
% TODO(Julia->MATLAB): mapV::MapV     = get_map(emm720),
                     cor_sigma      = 1.0,
                     cor_tau        = 600.0,
                     cor_var        = 1.0^2,
                     cor_drift      = 0.001,
                     cor_perm_mag   = 5.0,
                     cor_ind_mag    = 5.0,
                     cor_eddy_mag   = 0.5,
                     init_pos_sigma = 3.0,
                     init_alt_sigma = 0.001,
                     init_vel_sigma = 0.01,
                     init_att_sigma = deg2rad(0.01),
                     VRW_sigma      = 0.000238,
                     ARW_sigma      = 0.000000581,
                     baro_sigma     = 1.0,
                     ha_sigma       = 0.001,
                     a_hat_sigma    = 0.01,
                     acc_sigma      = 0.000245,
                     gyro_sigma     = 0.00000000727,
                     fogm_sigma     = 1.0,
                     baro_tau       = 3600.0,
                     acc_tau        = 3600.0,
                     gyro_tau       = 3600.0,
                     fogm_tau       = 600.0,
% TODO(Julia->MATLAB): save_h5::Bool  = false,
% TODO(Julia->MATLAB): xyz_h5::String = "xyz_data.h5",
% TODO(Julia->MATLAB): silent::Bool   = false)

    xyz_h5 = add_extension(xyz_h5,".h5")

    % create trajectory
    traj = create_traj(mapS;
                       alt      = alt,
                       dt       = dt,
                       t        = t,
                       v        = v,
                       ll1      = ll1,
                       ll2      = ll2,
                       N_waves  = N_waves,
                       attempts = attempts,
                       save_h5  = save_h5,
                       traj_h5  = xyz_h5)

    % create INS
    ins = create_ins(traj;
                     init_pos_sigma = init_pos_sigma,
                     init_alt_sigma = init_alt_sigma,
                     init_vel_sigma = init_vel_sigma,
                     init_att_sigma = init_att_sigma,
                     VRW_sigma      = VRW_sigma,
                     ARW_sigma      = ARW_sigma,
                     baro_sigma     = baro_sigma,
                     ha_sigma       = ha_sigma,
                     a_hat_sigma    = a_hat_sigma,
                     acc_sigma      = acc_sigma,
                     gyro_sigma     = gyro_sigma,
                     baro_tau       = baro_tau,
                     acc_tau        = acc_tau,
                     gyro_tau       = gyro_tau,
                     save_h5        = save_h5,
                     ins_h5         = xyz_h5)

    % create compensated (clean) scalar magnetometer measurements
    mag_1_c = create_mag_c(traj,mapS;
                           meas_var   = cor_var,
                           fogm_sigma = fogm_sigma,
                           fogm_tau   = fogm_tau,
                           silent     = silent)

    % create compensated (clean) vector magnetometer measurements
    flux_a = create_flux(traj,mapV;
                         meas_var   = cor_var,
                         fogm_sigma = fogm_sigma,
                         fogm_tau   = fogm_tau,
                         silent     = silent)

    % create uncompensated (corrupted) scalar magnetometer measurements
    (mag_1_uc,_,diurnal) = corrupt_mag(mag_1_c,flux_a;
                                       dt           = dt,
                                       cor_sigma    = cor_sigma,
                                       cor_tau      = cor_tau,
                                       cor_var      = cor_var,
                                       cor_drift    = cor_drift,
                                       cor_perm_mag = cor_perm_mag,
                                       cor_ind_mag  = cor_ind_mag,
                                       cor_eddy_mag = cor_eddy_mag)

    flights = flight*one(traj.lat)
    lines   = line  *one(traj.lat)
    years   = year  *one(traj.lat)
    doys    = doy   *one(traj.lat)

    igrf = zero(traj.lat)
    xyz  = XYZ0(info, traj, ins, flux_a, flights, lines,
                years, doys, diurnal, igrf, mag_1_c, mag_1_uc)
    igrf = norm(get_igrf(xyz;
% TODO(Julia->MATLAB): frame     = :body,
                          norm_igrf = false,
                          check_xyz = false))
    xyz.igrf = igrf

    if save_h5 % save `xyz_h5`
% TODO(Julia->MATLAB): h5open(xyz_h5,"cw") do file % read-write, create file if not existing, preserve existing contents
            write(file,"flux_a_x",flux_a.x)
            write(file,"flux_a_y",flux_a.y)
            write(file,"flux_a_z",flux_a.z)
            write(file,"flux_a_t",flux_a.t)
            write(file,"mag_1_uc",mag_1_uc)
            write(file,"mag_1_c" ,mag_1_c)
            write(file,"flight"  ,flights)
            write(file,"line"    ,lines)
            write(file,"year"    ,years)
            write(file,"doy"     ,doys)
            write(file,"diurnal" ,diurnal)
            write(file,"igrf"    ,igrf)
        end
end
