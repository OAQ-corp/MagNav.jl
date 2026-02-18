% Auto-generated from src/analysis_util.jl
% Original Julia signature: function project_vec_to_2d(vec_in, uvec_x, uvec_y)
% Mechanical conversion draft: review before production use.
function out = project_vec_to_2d(vec_in, uvec_x, uvec_y)
    assert abs(dot(uvec_x, uvec_y)) <= 1e-7 "projected vectors must be orthogonal: ", dot(uvec_x, uvec_y)
    assert norm(uvec_x) ≈ 1 "unit vector norm = $(norm(uvec_x)) ≠ 1"
    assert norm(uvec_y) ≈ 1 "unit vector norm = $(norm(uvec_y)) ≠ 1"
    [dot(vec_in,uvec_x), dot(vec_in,uvec_y)]
end % function project_vec_to_2d
end
