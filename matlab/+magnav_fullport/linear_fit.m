% Auto-generated from src/compensation.jl
% Original Julia signature: function linear_fit(x, y, no_norm = falses(size(x,2));
% Mechanical conversion draft: review before production use.
function out = linear_fit(x, y, no_norm, f_2_)
                    trim::Int           = 0,
                    λ::Real             = 0,
                    norm_type_x::Symbol = :none,
                    norm_type_y::Symbol = :none,
                    data_norms::Tuple   = (zeros(1,1),zeros(1,1),[0.0],[0.0]),
                    l_segs::Vector      = [length(y)],
                    silent::Bool        = false)

    % normalize data
    if sum(data_norms[end]) == 0 % normalize data
        (x_bias,x_scale,x_norm) = norm_sets(x;norm_type=norm_type_x,no_norm=no_norm)
        (y_bias,y_scale,y_norm) = norm_sets(y;norm_type=norm_type_y)
    else % unpack data normalizations
        (x_bias,x_scale,y_bias,y_scale) = data_norms
        x_norm = (x .- x_bias) ./ x_scale
        y_norm = (y .- y_bias) ./ y_scale
    end
end
