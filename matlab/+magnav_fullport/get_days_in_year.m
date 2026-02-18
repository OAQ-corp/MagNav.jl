% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_days_in_year(year)
% Mechanical conversion draft: review before production use.
function out = get_days_in_year(year)
    floor(Int,year) % 4 == 0 ? 366 : 365
end % function get_days_in_year
end
