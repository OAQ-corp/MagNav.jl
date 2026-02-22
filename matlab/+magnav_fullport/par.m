% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function par(val::SubString{String})
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = par(val)
    out = [];
    val == "*" ? NaN : parse(Float64,val)
end % function par
end
