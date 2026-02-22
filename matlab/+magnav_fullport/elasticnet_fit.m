% Auto-generated from src/compensation.jl
% Original Julia signature: function elasticnet_fit(x, y, α::Real = 0.99, no_norm = falses(size(x,2));
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = elasticnet_fit(x, y, f__, no_norm, f_2_)
    out = [];
% TODO(Julia->MATLAB): λ::Real           = -1,
% TODO(Julia->MATLAB): data_norms::Tuple = (zeros(1,1),zeros(1,1),[0.0],[0.0]),
% TODO(Julia->MATLAB): l_segs::Vector    = [length(y)],
% TODO(Julia->MATLAB): silent::Bool      = false)

% TODO(Julia->MATLAB): norm_type_x = :standardize
% TODO(Julia->MATLAB): norm_type_y = :standardize

    % normalize data
    if sum(data_norms(end)) == 0 % normalize data
        (x_bias,x_scale,x_norm) = norm_sets(x;norm_type=norm_type_x,no_norm=no_norm)
        (y_bias,y_scale,y_norm) = norm_sets(y;norm_type=norm_type_y)
    else % unpack data normalizations
        (x_bias,x_scale,y_bias,y_scale) = data_norms
        x_norm = (x .- x_bias) ./ x_scale
        y_norm = (y .- y_bias) ./ y_scale
    end
end
