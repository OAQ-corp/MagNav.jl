% Auto-generated from src/model_functions.jl
% Original Julia signature: function create_P0(lat1 = deg2rad(45);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function P0 = create_P0(lat1)
    P0 = [];
                   init_pos_sigma   = 3.0,
                   init_alt_sigma   = 0.001,
                   init_vel_sigma   = 0.01,
                   init_att_sigma   = deg2rad(0.01),
                   ha_sigma         = 0.001,
                   a_hat_sigma      = 0.01,
                   acc_sigma        = 0.000245,
                   gyro_sigma       = 0.00000000727,
                   fogm_sigma       = 3.0,
                   vec_sigma        = 1000.0,
% TODO(Julia->MATLAB): vec_states::Bool = false,
% TODO(Julia->MATLAB): fogm_state::Bool = true,
                   P0_TL            = [])

    nx_TL   = size(P0_TL,1)
    nx_vec  = vec_states ? 3 : 0
    nx_fogm = fogm_state ? 1 : 0

    nx = 17 + nx_TL + nx_vec + nx_fogm

    P0 = zeros(nx,nx) % initial covariance matrix

    P0(1,1)   = dn2dlat(init_pos_sigma,lat1)^2
    P0(2,2)   = de2dlon(init_pos_sigma,lat1)^2
    P0(3,3)   = init_alt_sigma^2
    P0(4,4)   = init_vel_sigma^2
    P0(5,5)   = init_vel_sigma^2
    P0(6,6)   = init_vel_sigma^2
    P0(7,7)   = init_att_sigma^2
    P0(8,8)   = init_att_sigma^2
    P0(9,9)   = init_att_sigma^2
    P0(10,10) = ha_sigma^2
    P0(11,11) = a_hat_sigma^2
    P0(12,12) = acc_sigma^2
    P0(13,13) = acc_sigma^2
    P0(14,14) = acc_sigma^2
    P0(15,15) = gyro_sigma^2
    P0(16,16) = gyro_sigma^2
    P0(17,17) = gyro_sigma^2

    i1 = 18
    i2 = i1 + nx_TL
    i3 = i2 + nx_vec
% TODO(Julia->MATLAB): nx_TL   > 0 && (P0(i1:i2-1,i1:i2-1) = P0_TL)
% TODO(Julia->MATLAB): nx_vec  > 0 && (P0(i2:i3-1,i2:i3-1) = Diagonal(repeat([vec_sigma^2],nx_vec)))
    nx_fogm > 0 && (P0(i3     ,i3     ) = fogm_sigma^2)

% return (P0)
end % function create_P0
end
