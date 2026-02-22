% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function field_check(s, field::Symbol, t::Union{DataType,UnionAll})
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = field_check__ovl3(s, field, t, UnionAll_)
    out = [];
    field_check(s,field)
% TODO(Julia->MATLAB): assert getfield(s,field) isa t "$field is not $t type"
end % function field_check
end
