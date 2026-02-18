% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function print_fields(s)
% Mechanical conversion draft: review before production use.
function out = print_fields(s)
    for field in fieldnames(typeof(s))
        t = typeof(getfield(s,field))
        if parentmodule(t) == MagNav
            for f in fieldnames(t)
                println("$field.$f  ",typeof(getfield(getfield(s,field),f)))
            end
end
