% Auto-generated from src/nekf.jl
% Original Julia signature: function ekf_single(lat, lon, alt, Phi, meas, itp_mapS, P            = create_P0(),
% Mechanical conversion draft: review before production use.
function [P, x] = ekf_single(lat, lon, alt, Phi, meas, itp_mapS, P)
                    P            = create_P0(),
                    Qd           = create_Qd(),
                    R            = 1.0,
                    R_nn         = 0.0,
                    x            = zeros(eltype(P),18);
                    date         = get_years(2020,185),
                    core::Bool   = false)

    assert !(itp_mapS isa Map_Cache) "Map_Cache not supported for nEKF training"

    ny = length(meas)

    % measurement residual [ny]
    resid = meas .- get_h(itp_mapS,x,lat,lon,alt;date=date,core=core)

    % measurement Jacobian (repeated gradient here) [ny x nx]
    H = repeat(get_H(itp_mapS,x,lat,lon,alt;date=date,core=core)',ny,1)

    % measurement residual covariance
    S = H*P*H' .+ R .* (1 + R_nn) % S_t [ny x ny]

    % Kalman gain
    K = (P*H') / S          % K_t [nx x ny]

    % state & covariance update
    x = x + K*resid         % x_t [nx]
    P = (I - K*H) * P       % P_t [nx x nx]

    % state & covariance propagate (predict)
    x = Phi*x               % x_t|t-1 [nx]
    P = Phi*P*Phi' + Qd     % P_t|t-1 [nx x nx]

end % function ekf_single
end
