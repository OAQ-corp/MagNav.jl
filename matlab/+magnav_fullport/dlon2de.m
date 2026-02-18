% Auto-generated from src/analysis_util.jl
% Original Julia signature: function dlon2de(dlon, lat)
% Mechanical conversion draft: review before production use.
function de = dlon2de(dlon, lat)
    de = dlon / sqrt(1-(e_earth*sin(lat))^2) * r_earth * cos(lat)
end % function dlon2de
end
