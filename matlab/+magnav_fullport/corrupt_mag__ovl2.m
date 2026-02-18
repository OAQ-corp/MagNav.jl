% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function corrupt_mag(mag_c, flux; dt           = 0.1, cor_sigma    = 1.0, cor_tau      = 600.0, cor_var      = 1.0^2, cor_drift    = 0.001, cor_perm_mag = 5.0, cor_ind_mag  = 5.0, cor_eddy_mag = 0.5)
% Mechanical conversion draft: review before production use.
function out = corrupt_mag__ovl2(mag_c, flux, varargin)
                     dt           = 0.1,
                     cor_sigma    = 1.0,
                     cor_tau      = 600.0,
                     cor_var      = 1.0^2,
                     cor_drift    = 0.001,
                     cor_perm_mag = 5.0,
                     cor_ind_mag  = 5.0,
                     cor_eddy_mag = 0.5)
    corrupt_mag(mag_c,flux.x,flux.y,flux.z;
                dt           = dt,
                cor_sigma    = cor_sigma,
                cor_tau      = cor_tau,
                cor_var      = cor_var,
                cor_drift    = cor_drift,
                cor_perm_mag = cor_perm_mag,
                cor_ind_mag  = cor_ind_mag,
                cor_eddy_mag = cor_eddy_mag)
end % function corrupt_mag
end
