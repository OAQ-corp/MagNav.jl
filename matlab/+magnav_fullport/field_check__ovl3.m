% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function field_check(s, field::Symbol, t::Union{DataType,UnionAll})
% Mechanical conversion draft: review before production use.
function out = field_check__ovl3(s, field, t, UnionAll_)
    field_check(s,field)
    assert getfield(s,field) isa t "$field is not $t type"
end % function field_check
end
