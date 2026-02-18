% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_border_clean!(ind::BitMatrix)
% Mechanical conversion draft: review before production use.
function out = map_border_clean_bang(ind)
    sum_ind = 0
    while sum_ind ~= sum(ind)
        sum_ind = sum(ind)
        ind_singles = map_border_singles(ind)
        ind_doubles = map_border_doubles(ind)
        ind .= ind .& .!ind_singles .& .!ind_doubles
    end
end
