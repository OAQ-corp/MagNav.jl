% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function field_check(s, t::Union{DataType,UnionAll})
% Mechanical conversion draft: review before production use.
function out = field_check(s, t, UnionAll_)
    fields = fieldnames(typeof(s))
    [fields[i] for i = findall([getfield(s,f) isa t for f in fields])]
end % function field_check
end
