% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function read_check(xyz::HDF5.File, field::Symbol, N::Int = 1, silent::Bool = false)
% Mechanical conversion draft: review before production use.
function out = read_check(xyz, field, N, silent)
    field = String(field)
    if field in keys(xyz)
        val = read(xyz,field)
    else
        val = fill(NaN,N)
    end
end
