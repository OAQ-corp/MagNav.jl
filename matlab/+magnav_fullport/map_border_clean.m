% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_border_clean(ind::BitMatrix)
% Mechanical conversion draft: review before production use.
function ind = map_border_clean(ind)
    ind = deepcopy(ind)
    map_border_clean!(ind)
end % function map_border_clean
end
