% Auto-generated from src/analysis_util.jl
% Original Julia signature: function de2dlon(de, lat)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function dlon = de2dlon(de, lat)
    dlon = [];
    dlon = de * sqrt(1-(e_earth*sin(lat))^2) / r_earth / cos(lat)
% return (dlon)
end % function de2dlon
end
