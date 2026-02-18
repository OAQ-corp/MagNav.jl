% Auto-generated from src/model_functions.jl
% Original Julia signature: function get_Phi(nx::Int, lat, vn, ve, vd, fn, fe, fd, Cnb, baro_tau, acc_tau, gyro_tau, fogm_tau, dt; vec_states::Bool = false, fogm_state::Bool = true)
% Mechanical conversion draft: review before production use.
function out = get_Phi(nx, lat, vn, ve, vd, fn, fe, fd, Cnb, baro_tau, acc_tau, gyro_tau, fogm_tau, dt, varargin)
                 baro_tau, acc_tau, gyro_tau, fogm_tau, dt;
                 vec_states::Bool = false,
                 fogm_state::Bool = true)

    exponential!(get_pinson(nx,lat,vn,ve,vd,fn,fe,fd,Cnb;
                            baro_tau   = baro_tau,
                            acc_tau    = acc_tau,
                            gyro_tau   = gyro_tau,
                            fogm_tau   = fogm_tau,
                            vec_states = vec_states,
                            fogm_state = fogm_state) * dt)

    % %* note: slightly more allocations & slightly slower
    % sparse(exponential!(get_pinson(nx,lat,vn,ve,vd,fn,fe,fd,Cnb;
    %                                baro_tau   = baro_tau,
    %                                acc_tau    = acc_tau,
    %                                gyro_tau   = gyro_tau,
    %                                fogm_tau   = fogm_tau,
    %                                vec_states = vec_states,
    %                                fogm_state = fogm_state) * dt))

end % function get_Phi
end
