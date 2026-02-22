% Auto-generated from src/analysis_util.jl
% Original Julia signature: function dlat2dn(dlat, lat)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function dn = dlat2dn(dlat, lat)
    dn = [];
    dn = dlat / sqrt(1-(e_earth*sin(lat))^2) * r_earth
% return (dn)
end % function dlat2dn
end
