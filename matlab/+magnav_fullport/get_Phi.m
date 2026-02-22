% Auto-generated from src/model_functions.jl
% Original Julia signature: function get_Phi(nx::Int, lat, vn, ve, vd, fn, fe, fd, Cnb, baro_tau, acc_tau, gyro_tau, fogm_tau, dt; vec_states::Bool = false, fogm_state::Bool = true)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_Phi(nx, lat, vn, ve, vd, fn, fe, fd, Cnb, baro_tau, acc_tau, gyro_tau, fogm_tau, dt, varargin)
    out = [];
                 baro_tau, acc_tau, gyro_tau, fogm_tau, dt;
% TODO(Julia->MATLAB): vec_states::Bool = false,
% TODO(Julia->MATLAB): fogm_state::Bool = true)

% TODO(Julia->MATLAB): exponential!(get_pinson(nx,lat,vn,ve,vd,fn,fe,fd,Cnb;
                            baro_tau   = baro_tau,
                            acc_tau    = acc_tau,
                            gyro_tau   = gyro_tau,
                            fogm_tau   = fogm_tau,
                            vec_states = vec_states,
                            fogm_state = fogm_state) * dt)

    % %* note: slightly more allocations & slightly slower
% TODO(Julia->MATLAB): % sparse(exponential!(get_pinson(nx,lat,vn,ve,vd,fn,fe,fd,Cnb;
    %                                baro_tau   = baro_tau,
    %                                acc_tau    = acc_tau,
    %                                gyro_tau   = gyro_tau,
    %                                fogm_tau   = fogm_tau,
    %                                vec_states = vec_states,
    %                                fogm_state = fogm_state) * dt))

end % function get_Phi
end
