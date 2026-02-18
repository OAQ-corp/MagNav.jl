% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_params(map_map::Array, map_xx::Vector = collect(axes(map_map,2)),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [ind0, ind1, nx, ny] = map_params(map_map, map_xx, f_2_)
    ind0 = [];
% TODO(Julia->MATLAB): map_xx::Vector = collect(axes(map_map,2)),
% TODO(Julia->MATLAB): map_yy::Vector = collect(axes(map_map,1)))

    map_map = deepcopy(map_map)
% TODO(Julia->MATLAB): replace!(map_map, NaN=>0) % just in case

    % map indices with (ind0) & without (ind1) zeros
    ind0 = map_map == 0
    ind1 = map_map .~= 0

    % map size
    (ny,nx) = size(map_map)
    assert nx == length(map_xx) "xx map dimensions are inconsistent"
    assert ny == length(map_yy) "yy map dimensions are inconsistent"

% return (ind0, ind1, nx, ny)
end % function map_params
end
