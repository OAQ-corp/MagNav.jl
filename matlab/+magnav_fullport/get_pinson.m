% Auto-generated from src/model_functions.jl
% Original Julia signature: function get_pinson(nx::Int, lat, vn, ve, vd, fn, fe, fd, Cnb; baro_tau         = 3600.0, acc_tau          = 3600.0, gyro_tau         = 3600.0, fogm_tau         = 600.0, vec_states::Bool = false, fogm_state::Bool = true, k1=3e-2, k2=3e-4, k3=1e-6)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_pinson(nx, lat, vn, ve, vd, fn, fe, fd, Cnb, varargin)
    out = [];
                    baro_tau         = 3600.0,
                    acc_tau          = 3600.0,
                    gyro_tau         = 3600.0,
                    fogm_tau         = 600.0,
% TODO(Julia->MATLAB): vec_states::Bool = false,
% TODO(Julia->MATLAB): fogm_state::Bool = true,
                    k1=3e-2, k2=3e-4, k3=1e-6)

    % for 40 states:
    %  19-37 TL   [-]     Tolles-Lawson coefficients
    %  38    Bx   [nT]    x vector magnetometer
    %  39    By   [nT]    y vector magnetometer
    %  40    Bz   [nT]    z vector magnetometer

    tan_l = tan(lat)
    cos_l = cos(lat)
    sin_l = sin(lat)

    F = zeros(nx,nx)

    F(1,3)   = -vn / r_earth^2
    F(1,4)   =  1  / r_earth

    F(2,1)   =  ve * tan_l / (r_earth * cos_l)
    F(2,3)   = -ve         / (cos_l*r_earth^2)
    F(2,5)   =  1          / (r_earth * cos_l)

    F(3,3)   = -k1
    F(3,6)   = -1
    F(3,10)  =  k1

    F(4,1)   = -ve * (2*ω_earth*cos_l + ve / (r_earth*cos_l^2))
    F(4,3)   = (ve^2*tan_l - vn*vd) / r_earth^2
    F(4,4)   =  vd / r_earth
    F(4,5)   = -2*(ω_earth*sin_l + ve*tan_l / r_earth)
    F(4,6)   =  vn / r_earth
    F(4,8)   = -fd
    F(4,9)   =  fe

    F(5,1)   =  2*ω_earth*(vn*cos_l - vd*sin_l) + vn*ve / (r_earth * cos_l^2)
    F(5,3)   = -ve*((vn*tan_l + vd) / r_earth^2)
    F(5,4)   =  2*ω_earth*sin_l + ve * tan_l / r_earth
    F(5,5)   =      (vn*tan_l + vd) / r_earth
    F(5,6)   =  2*ω_earth*cos_l + ve / r_earth
    F(5,7)   =  fd
    F(5,9)   = -fn

    F(6,1)   =  2*ω_earth*ve*sin_l
    F(6,3)   =  (vn^2 + ve^2) / r_earth^2 + k2
    F(6,4)   = -2*vn / r_earth
    F(6,5)   = -2*(ω_earth*cos_l + ve / r_earth)
    F(6,7)   = -fe
    F(6,8)   =  fn
    F(6,10)  = -k2
    F(6,11)  =  1

    F(7,1)   = -ω_earth*sin_l
    F(7,3)   = -ve^2 / r_earth^2
    F(7,5)   =  1 / r_earth
    F(7,8)   = -ω_earth*sin_l - ve*tan_l / r_earth
    F(7,9)   =  vn / r_earth

    F(8,3)   =  vn / r_earth^2
    F(8,4)   = -1 / r_earth
    F(8,7)   =  ω_earth*sin_l + ve*tan_l / r_earth
    F(8,9)   =  ω_earth*cos_l + ve / r_earth

    F(9,1)   = -ω_earth*cos_l - ve / (r_earth*cos_l^2)
    F(9,3)   =  ve*tan_l / r_earth^2
    F(9,5)   = -tan_l / r_earth
    F(9,7)   = -vn / r_earth
    F(9,8)   = -ω_earth*cos_l - ve / r_earth

    F(10,10) = -1 / baro_tau

    F(11,3)  =  k3
    F(11,10) = -k3

    F(12,12) = -1 / acc_tau
    F(13,13) = -1 / acc_tau
    F(14,14) = -1 / acc_tau
    F(15,15) = -1 / gyro_tau
    F(16,16) = -1 / gyro_tau
    F(17,17) = -1 / gyro_tau

    F(4:6,12:14) =  Cnb
    F(7:9,15:17) = -Cnb

    if vec_states
        nx_fogm = fogm_state ? 1 : 0
        F(end-nx_fogm-2,end-nx_fogm-2) = -1e9
        F(end-nx_fogm-1,end-nx_fogm-1) = -1e9
        F(end-nx_fogm  ,end-nx_fogm  ) = -1e9
    end
end
