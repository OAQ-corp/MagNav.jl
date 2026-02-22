% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_optimal_rotation_matrix(v1s, v2s)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function R = get_optimal_rotation_matrix(v1s, v2s)
    R = [];
    assert size(v1s,1) == size(v2s,1) "size(`v1s`,1) ≂̸ size(`v2s`,1)"
    assert size(v1s,2) == 3 "size(`v1s`,2) ≂̸ 3"
    assert size(v2s,2) == 3 "size(`v2s`,2) ≂̸ 3"

    % compute centroids and recenter point clouds
    v1_centroid   = mean(v1s,dims=1)
    v2_centroid   = mean(v2s,dims=1)
    v1_recentered = v1s .- v1_centroid
    v2_recentered = v2s .- v2_centroid

    % calculate cross-covariance matrix
    cov_matrix = v1_recentered'*v2_recentered

% TODO(Julia->MATLAB): % compute rotation matrix using least squares
    % R = sqrt(cov_matrix'*cov_matrix)*inv(cov_matrix)

% TODO(Julia->MATLAB): % compute rotation matrix using the Kabsch algorithm
    (U,_,V) = svd(cov_matrix)
    d = sign(det(V*transpose(U)))
    R = V*diagm([1.0,1.0,d])*transpose(U)

    assert det(R) ≈ 1 "rotation matrix should not scale"
    assert R*R' ≈ diagm([1.0,1.0,1.0]) "rotation matrix transpose should be its inverse"
% return (R)
end % function get_optimal_rotation_matrix
end
