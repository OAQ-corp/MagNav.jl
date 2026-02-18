% Auto-generated from src/analysis_util.jl
% Original Julia signature: function de2dlon(de, lat)
% Mechanical conversion draft: review before production use.
function dlon = de2dlon(de, lat)
    dlon = de * sqrt(1-(e_earth*sin(lat))^2) / r_earth / cos(lat)
end % function de2dlon
end
