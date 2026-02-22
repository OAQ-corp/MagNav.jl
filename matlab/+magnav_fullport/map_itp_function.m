% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_itp_function(itp_map::ScaledInterpolation{T1}) where T1
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function itp_map_3D = map_itp_function(itp_map)
    itp_map_3D = [];
    if length(size(itp_map)) == 2
% TODO(Julia->MATLAB): function itp_map_2D(yy::T1,xx::T1,alt::T1=yy) where T1
            itp_map(yy,xx)
        end
% return (itp_map_2D)
    elseif length(size(itp_map)) == 3
% TODO(Julia->MATLAB): function itp_map_3D(yy::T1,xx::T1,alt::T1) where T1
            itp_map(yy,xx,alt)
        end
% return (itp_map_3D)
    end
end
