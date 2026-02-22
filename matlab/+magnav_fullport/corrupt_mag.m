% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function corrupt_mag(mag_c, Bx, By, Bz; dt           = 0.1, cor_sigma    = 1.0, cor_tau      = 600.0, cor_var      = 1.0^2, cor_drift    = 0.001, cor_perm_mag = 5.0, cor_ind_mag  = 5.0, cor_eddy_mag = 0.5)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [mag_uc, TL_coef, cor_fogm] = corrupt_mag(mag_c, Bx, By, Bz, varargin)
    mag_uc = [];
                     dt           = 0.1,
                     cor_sigma    = 1.0,
                     cor_tau      = 600.0,
                     cor_var      = 1.0^2,
                     cor_drift    = 0.001,
                     cor_perm_mag = 5.0,
                     cor_ind_mag  = 5.0,
                     cor_eddy_mag = 0.5)

    P = Diagonal(vcat(repeat([cor_perm_mag],3),
                      repeat([cor_ind_mag ],6),
                      repeat([cor_eddy_mag],9))).^2

    % sample from MvNormal distribution with mean = 0, covariance = P
    TL_coef = vec(rand(MvNormal(P),1))

    N = length(mag_c)

    cor_fogm = fogm(cor_sigma,cor_tau,dt,N)

    mag_uc = mag_c + sqrt(cor_var)*randn(N) + cor_fogm +
% TODO(Julia->MATLAB): cor_drift*rand()*(0:dt:dt*(N-1))

    % corrupt with TL if vector magnetometer measurements are non-zero
% TODO(Julia->MATLAB): ~iszero(Bx) && (mag_uc += create_TL_A(Bx,By,Bz)*TL_coef)

% return (mag_uc, TL_coef, cor_fogm)
end % function corrupt_mag
end
