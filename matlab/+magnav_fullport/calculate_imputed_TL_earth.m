% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function calculate_imputed_TL_earth(xyz::XYZ, ind, map_val, set_igrf::Bool, TL_coef; terms    = [:permanent,:induced,:eddy], Bt_scale = 50000)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [TL_aircraft, B_earth] = calculate_imputed_TL_earth(xyz, ind, map_val, set_igrf, TL_coef, varargin)
    TL_aircraft = [];
% TODO(Julia->MATLAB): map_val, set_igrf::Bool, TL_coef;
% TODO(Julia->MATLAB): terms    = [:permanent,:induced,:eddy],
                                    Bt_scale = 50000)

    % get IGRF from model
    igrf_vec  = get_igrf(xyz,ind;
% TODO(Julia->MATLAB): frame     = :body,
                         norm_igrf = false,
% TODO(Julia->MATLAB): check_xyz = !set_igrf)
    set_igrf && (xyz.igrf(ind) = norm(igrf_vec))

    % obtain scalar map values with IGRF for this trajectory
    B_earth = map_val + norm(igrf_vec) % no diurnal

% TODO(Julia->MATLAB): % impute vector quantity using scaled IGRF vector field
    B_earth = reduce(hcat, B_earth .* normalize(igrf_vec))

    % time-derivative of vector field
    B_earth_dot = [fdm(B_earth(1,:)) fdm(B_earth(2,:)) fdm(B_earth(3,:))]'

    % Earth-only contribution to aircraft field
    (TL_coef_p,TL_coef_i,TL_coef_e) = TL_vec2mat(TL_coef,terms;Bt_scale=Bt_scale)
    TL_aircraft = get_TL_aircraft_vec(B_earth,B_earth_dot,TL_coef_p,TL_coef_i,TL_coef_e)

% return (TL_aircraft, B_earth)
end % function calculate_imputed_TL_earth
end
