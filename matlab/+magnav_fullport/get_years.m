% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_years(year, doy)
% Mechanical conversion draft: review before production use.
function out = get_years(year, doy)
    round(Int,year) + doy/get_days_in_year(year)
end % function get_years
end
