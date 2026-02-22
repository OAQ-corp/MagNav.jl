% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function field_extrema(xyz::XYZ, field::Symbol, val)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = field_extrema(xyz, field, val)
    out = [];
    if sum(getfield(xyz,field)==val) > 0
        extrema(xyz.traj.tt(getfield(xyz,field)==val))
    else
% TODO(Julia->MATLAB): error("$val not in $field")
    end
end
