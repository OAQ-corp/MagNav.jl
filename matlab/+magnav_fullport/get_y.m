% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_y(xyz::XYZ, ind = trues(xyz.traj.N),
% Mechanical conversion draft: review before production use.
function out = get_y(xyz, ind)
               map_val           = -1;
               y_type::Symbol    = :d,
               use_mag::Symbol   = :mag_1_uc,
               use_mag_c::Symbol = :mag_1_c,
               sub_diurnal::Bool = false,
               sub_igrf::Bool    = false)

    % selected scalar mags, as needed
    if y_type in [:c,:d,:e]
        if getfield(xyz,use_mag) isa MagV
            mag_uc = getfield(xyz,use_mag)(ind).t
        else
            mag_uc = getfield(xyz,use_mag)[ind]
        end
end
