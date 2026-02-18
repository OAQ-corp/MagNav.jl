% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_correct_igrf(map_map::Matrix, map_alt, map_xx::Vector, map_yy::Vector; sub_igrf_date::Real = get_years(2013,293),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function map_map = map_correct_igrf(map_map, map_alt, map_xx, map_yy, varargin)
    map_map = [];
% TODO(Julia->MATLAB): map_xx::Vector, map_yy::Vector;
% TODO(Julia->MATLAB): sub_igrf_date::Real = get_years(2013,293),
% TODO(Julia->MATLAB): add_igrf_date::Real = -1,
% TODO(Julia->MATLAB): zone_utm::Int       = 18,
% TODO(Julia->MATLAB): is_north::Bool      = true,
% TODO(Julia->MATLAB): map_units::Symbol   = :rad)
    map_map = float(map_map)
% TODO(Julia->MATLAB): map_correct_igrf!(map_map,map_alt,map_xx,map_yy;
                      sub_igrf_date = sub_igrf_date,
                      add_igrf_date = add_igrf_date,
                      zone_utm      = zone_utm,
                      is_north      = is_north,
                      map_units     = map_units)
% return (map_map)
end % function map_correct_igrf
end
