% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function compare_fields(s1, s2; silent::Bool = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = compare_fields(s1, s2, varargin)
    out = [];
    t1 = typeof(s1)
    t2 = typeof(s2)
% TODO(Julia->MATLAB): assert t1 == t2 "$t1 & $t2 types do no match"
    N_dif = 0;
% TODO(Julia->MATLAB): for field in fieldnames(t1)
        t  = typeof(getfield(s1,field))
        f1 = getfield(s1,field)
        f2 = getfield(s2,field)
        if parentmodule(t) == MagNav
            N_dif_add = compare_fields(f1,f2;silent=true)
% TODO(Julia->MATLAB): N_dif_add == 0 || println("($field is above)")
% TODO(Julia->MATLAB): N_dif += N_dif_add
        else
            if eltype(f1) <: Number
                if size(f1) ~= size(f2)
% TODO(Julia->MATLAB): println("size of $field field is different")
% TODO(Julia->MATLAB): N_dif += 1
                else
                    dif = sum(abs(f1 - f2))
% TODO(Julia->MATLAB): dif ≈ 0 || println("$field  ",dif)
% TODO(Julia->MATLAB): dif ≈ 0 || (N_dif += 1)
                end
end
