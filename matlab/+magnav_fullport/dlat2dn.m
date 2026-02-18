% Auto-generated from src/analysis_util.jl
% Original Julia signature: function dlat2dn(dlat, lat)
% Mechanical conversion draft: review before production use.
function dn = dlat2dn(dlat, lat)
    dn = dlat / sqrt(1-(e_earth*sin(lat))^2) * r_earth
end % function dlat2dn
end
