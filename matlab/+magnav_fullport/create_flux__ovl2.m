% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function create_flux(path::Path, mapV::MapV = get_map(emm720);
% Mechanical conversion draft: review before production use.
function out = create_flux__ovl2(path, mapV)
                     meas_var     = 1.0^2,
                     fogm_sigma   = 1.0,
                     fogm_tau     = 600.0,
                     silent::Bool = false)
    create_flux(path.lat,path.lon,mapV;
                Cnb        = path.Cnb,
                alt        = median(path.alt),
                dt         = path.dt,
                meas_var   = meas_var,
                fogm_sigma = fogm_sigma,
                fogm_tau   = fogm_tau,
                silent     = silent)
end % function create_flux
end
