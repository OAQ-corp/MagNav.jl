% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function read_check(xyz::HDF5.File, field::Symbol, default::String)
% Mechanical conversion draft: review before production use.
function val = read_check__ovl2(xyz, field, default)
    field = String(field)
    val   = field in keys(xyz) ? read(xyz,field) : default
end % function read_check
end
