% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_years(year, doy)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_years(year, doy)
    out = [];
    round(Int,year) + doy/get_days_in_year(year)
end % function get_years
end
