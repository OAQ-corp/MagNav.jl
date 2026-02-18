% Auto-generated from src/analysis_util.jl
% Original Julia signature: function dn2dlat(dn, lat)
% Mechanical conversion draft: review before production use.
function dlat = dn2dlat(dn, lat)
    dlat = dn * sqrt(1-(e_earth*sin(lat))^2) / r_earth
end % function dn2dlat
end
