% Auto-generated from src/analysis_util.jl
% Original Julia signature: function project_vec_to_2d(vec_in, uvec_x, uvec_y)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = project_vec_to_2d(vec_in, uvec_x, uvec_y)
    out = [];
    assert abs(dot(uvec_x, uvec_y)) <= 1e-7 "projected vectors must be orthogonal: ", dot(uvec_x, uvec_y)
% TODO(Julia->MATLAB): assert norm(uvec_x) ≈ 1 "unit vector norm = $(norm(uvec_x)) ≠ 1"
% TODO(Julia->MATLAB): assert norm(uvec_y) ≈ 1 "unit vector norm = $(norm(uvec_y)) ≠ 1"
    [dot(vec_in,uvec_x), dot(vec_in,uvec_y)]
end % function project_vec_to_2d
end
