% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_params(map_map::Array, map_xx::Vector = collect(axes(map_map,2)),
% Mechanical conversion draft: review before production use.
function [ind0, ind1, nx, ny] = map_params(map_map, map_xx, f_2_)
                    map_xx::Vector = collect(axes(map_map,2)),
                    map_yy::Vector = collect(axes(map_map,1)))

    map_map = deepcopy(map_map)
    replace!(map_map, NaN=>0) % just in case

    % map indices with (ind0) & without (ind1) zeros
    ind0 = map_map .== 0
    ind1 = map_map .~= 0

    % map size
    (ny,nx) = size(map_map)
    assert nx == length(map_xx) "xx map dimensions are inconsistent"
    assert ny == length(map_yy) "yy map dimensions are inconsistent"

end % function map_params
end
