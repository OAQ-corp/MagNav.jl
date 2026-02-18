% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_interpolate(map_map::AbstractArray{T}, map_xx::AbstractVector{T}, map_yy::AbstractVector{T}, type::Symbol = :cubic, map_alt::AbstractVector{T} = T[0]) where T
% Mechanical conversion draft: review before production use.
function out = map_interpolate(map_map, map_xx, map_yy, type, map_alt)
                         map_xx::AbstractVector{T},
                         map_yy::AbstractVector{T},
                         type::Symbol = :cubic,
                         map_alt::AbstractVector{T} = T[0]) where T

    % uses Interpolations package rather than Dierckx or GridInterpolations,
    % as Interpolations was found to be fastest for MagNav use cases.

    (ny,nx,nz) = length.((map_yy,map_xx,map_alt))
    assert nx == size(map_map,2)  "xx map dimensions are inconsistent"
    assert ny == size(map_map,1)  "yy map dimensions are inconsistent"
    assert nz == size(map_map,3) "alt map dimensions are inconsistent"

    if type == :linear
        spline_type = BSpline(Linear())
    elseif type == :quad
        spline_type = BSpline(Quadratic(Line(OnGrid())))
    elseif type == :cubic
        spline_type = BSpline(Cubic(Line(OnGrid())))
    else
        error("$type interpolation type not defined")
    end
end
