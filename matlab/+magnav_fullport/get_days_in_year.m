% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_days_in_year(year)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_days_in_year(year)
    out = [];
    floor(Int,year) % 4 == 0 ? 366 : 365
end % function get_days_in_year
end
