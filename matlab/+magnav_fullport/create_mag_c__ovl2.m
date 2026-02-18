% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function create_mag_c(path::Path, mapS::Union{MapS,MapSd,MapS3D} = get_map(namad);
% Mechanical conversion draft: review before production use.
function out = create_mag_c__ovl2(path, mapS, MapSd, MapS3D_)
                      meas_var     = 1.0^2,
                      fogm_sigma   = 1.0,
                      fogm_tau     = 600.0,
                      silent::Bool = false)
    create_mag_c(path.lat,path.lon,mapS;
                 alt        = median(path.alt),
                 dt         = path.dt,
                 meas_var   = meas_var,
                 fogm_sigma = fogm_sigma,
                 fogm_tau   = fogm_tau,
                 silent     = silent)
end % function create_mag_c
end
