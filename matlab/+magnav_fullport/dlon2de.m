% Auto-generated from src/analysis_util.jl
% Original Julia signature: function dlon2de(dlon, lat)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function de = dlon2de(dlon, lat)
    de = [];
    de = dlon / sqrt(1-(e_earth*sin(lat))^2) * r_earth * cos(lat)
% return (de)
end % function dlon2de
end
