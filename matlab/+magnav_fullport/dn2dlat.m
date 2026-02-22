% Auto-generated from src/analysis_util.jl
% Original Julia signature: function dn2dlat(dn, lat)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function dlat = dn2dlat(dn, lat)
    dlat = [];
    dlat = dn * sqrt(1-(e_earth*sin(lat))^2) / r_earth
% return (dlat)
end % function dn2dlat
end
