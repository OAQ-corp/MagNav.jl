% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function read_check(xyz::HDF5.File, field::Symbol, N::Int = 1, silent::Bool = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = read_check(xyz, field, N, silent)
    out = [];
    field = String(field)
% TODO(Julia->MATLAB): if field in keys(xyz)
        val = read(xyz,field)
    else
        val = fill(NaN,N)
    end
end
