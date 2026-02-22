% Auto-generated from src/eval_filt.jl
% Original Julia signature: function units_ellipse(P; conf_units::Symbol = :m, lat1 = deg2rad(45))
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = units_ellipse(P, varargin)
    out = [];
% TODO(Julia->MATLAB): assert size(P,1) == 2 "P is size $(size(P)) ≂̸ (2,2)"
% TODO(Julia->MATLAB): assert size(P,2) == 2 "P is size $(size(P)) ≂̸ (2,2)"

    P = float(P)

% TODO(Julia->MATLAB): if conf_units == :deg
        P = rad2deg(rad2deg(P)) % deg^2
% TODO(Julia->MATLAB): elseif conf_units in [:m,:ft]
        l = [dlat2dn(1,lat1),dlon2de(1,lat1)] % m/rad
% TODO(Julia->MATLAB): conf_units == :ft && (l ./= 0.3048)   % ft/rad
        P = P .* (l*l') % m^2 or ft^2
% TODO(Julia->MATLAB): elseif conf_units ~= :rad
% TODO(Julia->MATLAB): error("$conf_units confidence ellipse units not defined")
    end
end
