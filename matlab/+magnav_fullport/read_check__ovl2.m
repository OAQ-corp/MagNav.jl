% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function read_check(xyz::HDF5.File, field::Symbol, default::String)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function val = read_check__ovl2(xyz, field, default)
    val = [];
    field = String(field)
% TODO(Julia->MATLAB): val   = field in keys(xyz) ? read(xyz,field) : default
% return (val)
end % function read_check
end
