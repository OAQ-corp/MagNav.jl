% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_chessboard(mapSd::MapSd, alt::Real; down_cont::Bool = true, dz              = 5, down_max        = 150, α               = 200)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_chessboard(mapSd, alt, varargin)
    out = [];
% TODO(Julia->MATLAB): down_cont::Bool = true,
                        dz              = 5,
                        down_max        = 150,
                        α               = 200)
    mapSd  = deepcopy(mapSd)
    map_xx = zero(mapSd.xx)
    map_yy = zero(mapSd.yy)
% TODO(Julia->MATLAB): for i in eachindex(map_xx)[2:end]
        map_xx(i) = map_xx(i-1) + dlon2de(mapSd.xx(i) - mapSd.xx(i-1),
                                          mean(mapSd.yy))
    end
end
