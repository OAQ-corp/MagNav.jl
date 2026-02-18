% Auto-generated from src/model_functions.jl
% Original Julia signature: function create_model(dt = 0.1, lat1 = deg2rad(45);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [P0, Qd, R] = create_model(dt, lat1)
    P0 = [];
                      init_pos_sigma   = 3.0,
                      init_alt_sigma   = 0.001,
                      init_vel_sigma   = 0.01,
                      init_att_sigma   = deg2rad(0.01),
                      meas_var         = 3.0^2,
                      VRW_sigma        = 0.000238,
                      ARW_sigma        = 0.000000581,
                      baro_sigma       = 1.0,
                      ha_sigma         = 0.001,
                      a_hat_sigma      = 0.01,
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
% TODO(Julia->MATLAB): fogm_state::Bool = true,
                      P0_TL            = [])

    P0 = create_P0(lat1;
                   init_pos_sigma = init_pos_sigma,
                   init_alt_sigma = init_alt_sigma,
                   init_vel_sigma = init_vel_sigma,
                   init_att_sigma = init_att_sigma,
                   ha_sigma       = ha_sigma,
                   a_hat_sigma    = a_hat_sigma,
                   acc_sigma      = acc_sigma,
                   gyro_sigma     = gyro_sigma,
                   fogm_sigma     = fogm_sigma,
                   vec_sigma      = vec_sigma,
                   vec_states     = vec_states,
                   fogm_state     = fogm_state,
                   P0_TL          = P0_TL)

    Qd = create_Qd(dt;
                   VRW_sigma  = VRW_sigma,
                   ARW_sigma  = ARW_sigma,
                   baro_sigma = baro_sigma,
                   acc_sigma  = acc_sigma,
                   gyro_sigma = gyro_sigma,
                   fogm_sigma = fogm_sigma,
                   vec_sigma  = vec_sigma,
                   TL_sigma   = TL_sigma,
                   baro_tau   = baro_tau,
                   acc_tau    = acc_tau,
                   gyro_tau   = gyro_tau,
                   fogm_tau   = fogm_tau,
                   vec_states = vec_states,
                   fogm_state = fogm_state)

    R = meas_var % measurement (white) noise variance [nT^2]

% return (P0, Qd, R)
end % function create_model
end
