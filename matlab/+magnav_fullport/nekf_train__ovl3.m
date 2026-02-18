% Auto-generated from src/nekf.jl
% Original Julia signature: function nekf_train(xyz::XYZ, ind, meas, itp_mapS, x::Matrix; P0                   = create_P0(),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [m, data_norms] = nekf_train__ovl3(xyz, ind, meas, itp_mapS, x, varargin)
    m = [];
                    P0                   = create_P0(),
                    Qd                   = create_Qd(),
                    R                    = 1.0,
                    baro_tau             = 3600.0,
                    acc_tau              = 3600.0,
                    gyro_tau             = 3600.0,
                    fogm_tau             = 600.0,
                    η_adam               = 0.1,
% TODO(Julia->MATLAB): epoch_adam::Int      = 10,
% TODO(Julia->MATLAB): hidden::Int          = 1,
% TODO(Julia->MATLAB): activation::Function = swish,
% TODO(Julia->MATLAB): l_window::Int        = 50,
                    date                 = get_years(2020,185),
% TODO(Julia->MATLAB): core::Bool           = false)

    % get traj, ins, & y_nn (position)
    traj = get_traj(xyz,ind)
    ins  = get_ins(xyz,ind;N_zero_ll=1)
    y_nn = [traj.lat traj.lon]

    % normalize x
% TODO(Julia->MATLAB): (x_bias,x_scale,x_norm) = norm_sets(x;norm_type=:standardize)
    (_,S,V) = svd(cov(x_norm))
    v_scale = V(:,1:1)*inv(Diagonal(sqrt(S(1:1))))
    x_nn = x_norm * v_scale

    m = nekf_train(ins,meas,itp_mapS,x_nn,y_nn;
                   P0=P0,Qd=Qd,R=R,
                   baro_tau   = baro_tau,
                   acc_tau    = acc_tau,
                   gyro_tau   = gyro_tau,
                   fogm_tau   = fogm_tau,
                   η_adam     = η_adam,
                   epoch_adam = epoch_adam,
                   hidden     = hidden,
                   activation = activation,
                   l_window   = l_window,
                   date       = date,
                   core       = core)

    % pack normalizations
    data_norms = (v_scale,x_bias,x_scale)

% return (m, data_norms)
end % function nekf_train
end
