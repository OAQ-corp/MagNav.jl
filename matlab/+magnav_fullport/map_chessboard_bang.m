% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_chessboard!(map_map::Matrix, map_alt::Matrix, map_xx::Vector, map_yy::Vector, alt::Real; down_cont::Bool = true, dz              = 5, down_max        = 150, α               = 200)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_chessboard_bang(map_map, map_alt, map_xx, map_yy, alt, varargin)
    out = [];
% TODO(Julia->MATLAB): map_yy::Vector, alt::Real;
% TODO(Julia->MATLAB): down_cont::Bool = true,
                         dz              = 5,
                         down_max        = 150,
                         α               = 200)

    (ind0 ,ind1 ,nx ,ny ) = map_params(map_map,map_xx,map_yy)
    (ind0_,ind1_,nx_,ny_) = map_params(map_alt,map_xx,map_yy)

    assert (nx,ny) == (nx_,ny_) "map dimensions are inconsistent for chessboard method"
    assert sum(ind0 )/sum(ind0 +ind1 ) < 0.01 "target   map must be filled for chessboard method"
    assert sum(ind0_)/sum(ind0_+ind1_) < 0.01 "altitude map must be filled for chessboard method"

    % map step sizes (spacings)
    dx = get_step(map_xx)
    dy = get_step(map_yy)

    alt_min = floor(minimum(map_alt(ind1)))
    alt_max = ceil( maximum(map_alt(ind1)))

    up_max = 500
% TODO(Julia->MATLAB): alt_max - alt > down_max && @info("limiting downward continuation to alt_max = $alt_max m - $down_max m for chessboard method")
% TODO(Julia->MATLAB): alt - alt_min > up_max   && @info("limiting upward continuation to alt_min = $alt_min m + $up_max m for chessboard method")
    alt_dif_down = clamp(alt_max - alt, 0, down_max)
    alt_dif_up   = clamp(alt - alt_min, 0, up_max)
% TODO(Julia->MATLAB): alt_lev_down = 0:dz:alt_dif_down+dz % downward continuation levels
% TODO(Julia->MATLAB): alt_lev_up   = 0:dz:alt_dif_up+dz   % upward   continuation levels

    if down_cont
% TODO(Julia->MATLAB): alt_lev = -alt_lev_down(end):dz:alt_lev_up(end)
        k0 = length(alt_lev_down)
    else
        alt_lev = alt_lev_up
        k0 = 1
    end
end
