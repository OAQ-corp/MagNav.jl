% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_y(xyz::XYZ, ind = trues(xyz.traj.N),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_y(xyz, ind)
    out = [];
               map_val           = -1;
% TODO(Julia->MATLAB): y_type::Symbol    = :d,
% TODO(Julia->MATLAB): use_mag::Symbol   = :mag_1_uc,
% TODO(Julia->MATLAB): use_mag_c::Symbol = :mag_1_c,
% TODO(Julia->MATLAB): sub_diurnal::Bool = false,
% TODO(Julia->MATLAB): sub_igrf::Bool    = false)

    % selected scalar mags, as needed
% TODO(Julia->MATLAB): if y_type in [:c,:d,:e]
        if getfield(xyz,use_mag) isa MagV
            mag_uc = getfield(xyz,use_mag)(ind).t
        else
% TODO(Julia->MATLAB): mag_uc = getfield(xyz,use_mag)[ind]
        end
end
