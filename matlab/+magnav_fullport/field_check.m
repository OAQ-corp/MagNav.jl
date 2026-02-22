% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function field_check(s, t::Union{DataType,UnionAll})
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = field_check(s, t, UnionAll_)
    out = [];
    fields = fieldnames(typeof(s))
% TODO(Julia->MATLAB): [fields(i) for i = findall([getfield(s,f) isa t for f in fields])]
end % function field_check
end
