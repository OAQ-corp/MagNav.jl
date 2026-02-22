% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function print_fields(s)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = print_fields(s)
    out = [];
% TODO(Julia->MATLAB): for field in fieldnames(typeof(s))
        t = typeof(getfield(s,field))
        if parentmodule(t) == MagNav
% TODO(Julia->MATLAB): for f in fieldnames(t)
% TODO(Julia->MATLAB): println("$field.$f  ",typeof(getfield(getfield(s,field),f)))
            end
end
