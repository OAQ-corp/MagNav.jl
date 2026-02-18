% Auto-generated from src/analysis_util.jl
% Original Julia signature: function krr_fit(x, y, no_norm = falses(size(x,2));
% Mechanical conversion draft: review before production use.
function out = krr_fit(x, y, no_norm, f_2_)
                 k::Kernel           = PolynomialKernel(;degree=1),
                 λ::Real             = 0.5,
                 norm_type_x::Symbol = :standardize,
                 norm_type_y::Symbol = :standardize,
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
