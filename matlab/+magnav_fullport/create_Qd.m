% Auto-generated from src/model_functions.jl
% Original Julia signature: function create_Qd(dt = 0.1; VRW_sigma        = 0.000238, ARW_sigma        = 0.000000581, baro_sigma       = 1.0, acc_sigma        = 0.000245, gyro_sigma       = 0.00000000727, fogm_sigma       = 3.0, vec_sigma        = 1000.0, TL_sigma         = [], baro_tau         = 3600.0, acc_tau          = 3600.0, gyro_tau         = 3600.0, fogm_tau         = 600.0, vec_states::Bool = false, fogm_state::Bool = true)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function Qd = create_Qd(dt, varargin)
    Qd = [];
                   VRW_sigma        = 0.000238,
                   ARW_sigma        = 0.000000581,
                   baro_sigma       = 1.0,
                   acc_sigma        = 0.000245,
                   gyro_sigma       = 0.00000000727,
                   fogm_sigma       = 3.0,
                   vec_sigma        = 1000.0,
                   TL_sigma         = [],
                   baro_tau         = 3600.0,
                   acc_tau          = 3600.0,
                   gyro_tau         = 3600.0,
                   fogm_tau         = 600.0,
% TODO(Julia->MATLAB): vec_states::Bool = false,
% TODO(Julia->MATLAB): fogm_state::Bool = true)

    VRW_var    = VRW_sigma^2    % velocity random walk noise variance
    ARW_var    = ARW_sigma^2    % angular  random walk noise variance
    baro_drive = 2*baro_sigma^2 / baro_tau  % barometer      driving noise
    acc_drive  = 2*acc_sigma^2  / acc_tau   % accelerometer  driving noise
    gyro_drive = 2*gyro_sigma^2 / gyro_tau  % gyroscope      driving noise
    fogm_drive = 2*fogm_sigma^2 / fogm_tau  % FOGM catch-all driving noise
    TL_var     = TL_sigma.^2    % Tolles-Lawson coefficient noise variance
    vec_var    = vec_sigma^2    % vector magnetometer noise variance

    nx_TL   = size(TL_sigma,1)
    nx_vec  = vec_states ? 3 : 0
    nx_fogm = fogm_state ? 1 : 0

    Q = [repeat([1e-30  ],3);
         repeat([VRW_var],3);
         repeat([ARW_var],3);
         baro_drive;
         1e-30;
         repeat([acc_drive ],3);
         repeat([gyro_drive],3);
         zeros(nx_TL+nx_vec+nx_fogm)]

    i1 = 18
    i2 = i1 + nx_TL
    i3 = i2 + nx_vec
% TODO(Julia->MATLAB): nx_TL   > 0 && (Q(i1:i2-1) = vec(TL_var))
% TODO(Julia->MATLAB): nx_vec  > 0 && (Q(i2:i3-1) = repeat([vec_var],3))
    nx_fogm > 0 && (Q(i3     ) = fogm_drive)

    Qd = Diagonal(Q)*dt % discrete time process/system noise matrix

% return (Qd)
end % function create_Qd
end
