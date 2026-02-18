% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function field_extrema(xyz::XYZ, field::Symbol, val)
% Mechanical conversion draft: review before production use.
function out = field_extrema(xyz, field, val)
    if sum(getfield(xyz,field).==val) > 0
        extrema(xyz.traj.tt[getfield(xyz,field).==val])
    else
        error("$val not in $field")
    end
end
