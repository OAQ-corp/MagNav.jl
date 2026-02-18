% Auto-generated from src/analysis_util.jl
% Original Julia signature: function project_body_field_to_2d_igrf(vec_body, igrf_nav, Cnb)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function v_out = project_body_field_to_2d_igrf(vec_body, igrf_nav, Cnb)
    v_out = [];
% TODO(Julia->MATLAB): % assume igrf_nav is "north" in navigation frame and rotate about Z axis to get "east"
    igrf_north     = igrf_nav  % components are [north, east, down]
    igrf_tan_earth = cross(igrf_north, [0.0, 0.0, -1.0]) % cross product with "up" direction
    igrf_east      = normalize(igrf_tan_earth)

    % transform aircraft vector from body to navigation frame
    vec_nav = Cnb*vec_body

    v_out = project_vec_to_2d(vec_nav,igrf_north,igrf_east)
% return (v_out)
end % function project_body_field_to_2d_igrf
end
