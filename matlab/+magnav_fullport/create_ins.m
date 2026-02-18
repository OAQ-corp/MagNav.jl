% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function create_ins(traj::Traj; init_pos_sigma = 3.0, init_alt_sigma = 0.001, init_vel_sigma = 0.01, init_att_sigma = deg2rad(0.00001),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = create_ins(traj, varargin)
    out = [];
                    init_pos_sigma = 3.0,
                    init_alt_sigma = 0.001,
                    init_vel_sigma = 0.01,
                    init_att_sigma = deg2rad(0.00001),
                    VRW_sigma      = 0.000238,
                    ARW_sigma      = 0.000000581,
                    baro_sigma     = 1.0,
                    ha_sigma       = 0.001,
                    a_hat_sigma    = 0.01,
                    acc_sigma      = 0.000245,
                    gyro_sigma     = 0.00000000727,
                    baro_tau       = 3600.0,
                    acc_tau        = 3600.0,
                    gyro_tau       = 3600.0,
% TODO(Julia->MATLAB): save_h5::Bool  = false,
% TODO(Julia->MATLAB): ins_h5::String = "ins_data.h5")

    ins_h5 = add_extension(ins_h5,".h5")

    N  = traj.N
    dt = traj.dt
    nx = 17 % total state dimension (inherent to this model)

    (P0,Qd,_) = create_model(dt,traj.lat(1);
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
                             fogm_state     = false)

    P   = zeros(nx,nx,N)
    err = zeros(nx,N)

    P(:,:,1) = P0
    err(:,1) = rand(MvNormal(P0),1) % mean = 0, covariance = P0
    Q_chol   = chol(Qd)

% TODO(Julia->MATLAB): for k = 1:N-1
        Phi = get_Phi(nx,traj.lat(k),traj.vn(k),traj.ve(k),traj.vd(k),
                      traj.fn(k),traj.fe(k),traj.fd(k),traj.Cnb(:,:,k),
                      baro_tau,acc_tau,gyro_tau,0,dt;fogm_state=false)
        err(:,k+1) = Phi*err(:,k) + Q_chol*randn(nx)
        P(:,:,k+1) = Phi*P(:,:,k)*Phi' + Qd
    end
end
