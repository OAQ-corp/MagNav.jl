% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function par(val::SubString{String})
% Mechanical conversion draft: review before production use.
function out = par(val)
    val == "*" ? NaN : parse(Float64,val)
end % function par
end
