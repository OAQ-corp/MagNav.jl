% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_interpolate(map_map::AbstractArray{T}, map_xx::AbstractVector{T}, map_yy::AbstractVector{T}, type::Symbol = :cubic, map_alt::AbstractVector{T} = T[0]) where T
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_interpolate(map_map, map_xx, map_yy, type, map_alt)
    out = [];
% TODO(Julia->MATLAB): map_xx::AbstractVector{T},
% TODO(Julia->MATLAB): map_yy::AbstractVector{T},
% TODO(Julia->MATLAB): type::Symbol = :cubic,
% TODO(Julia->MATLAB): map_alt::AbstractVector{T} = T(0)) where T

    % uses Interpolations package rather than Dierckx or GridInterpolations,
    % as Interpolations was found to be fastest for MagNav use cases.

    (ny,nx,nz) = length((map_yy,map_xx,map_alt))
    assert nx == size(map_map,2)  "xx map dimensions are inconsistent"
    assert ny == size(map_map,1)  "yy map dimensions are inconsistent"
    assert nz == size(map_map,3) "alt map dimensions are inconsistent"

% TODO(Julia->MATLAB): if type == :linear
        spline_type = BSpline(Linear())
% TODO(Julia->MATLAB): elseif type == :quad
        spline_type = BSpline(Quadratic(Line(OnGrid())))
% TODO(Julia->MATLAB): elseif type == :cubic
        spline_type = BSpline(Cubic(Line(OnGrid())))
    else
% TODO(Julia->MATLAB): error("$type interpolation type not defined")
    end
end
