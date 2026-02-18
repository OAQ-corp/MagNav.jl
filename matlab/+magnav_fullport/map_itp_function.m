% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_itp_function(itp_map::ScaledInterpolation{T1}) where T1
% Mechanical conversion draft: review before production use.
function itp_map_3D = map_itp_function(itp_map)
    if length(size(itp_map)) == 2
        function itp_map_2D(yy::T1,xx::T1,alt::T1=yy) where T1
            itp_map(yy,xx)
        end
    elseif length(size(itp_map)) == 3
        function itp_map_3D(yy::T1,xx::T1,alt::T1) where T1
            itp_map(yy,xx,alt)
        end
    end
end
