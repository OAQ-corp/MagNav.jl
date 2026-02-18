% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function field_check(s, field::Symbol)
% Mechanical conversion draft: review before production use.
function out = field_check__ovl2(s, field)
    t = typeof(s)
    assert field in fieldnames(t) "$field field not in $t type"
end % function field_check
end
