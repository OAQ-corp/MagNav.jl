% Auto-generated from src/eval_filt.jl
% Original Julia signature: function points_ellipse(P; clip = Inf, n::Int = 61)
% Mechanical conversion draft: review before production use.
function [x, y] = points_ellipse(P, varargin)
    θ = LinRange(0,2*pi,n) % angles around circle

    (eigval,eigvec) = eigen(P); % eigenvalues & eigenvectors
    xy = [cos.(θ) sin.(θ)] * sqrt.(Diagonal(eigval)) * eigvec' % transformation
    x  = xy[:,1]
    y  = xy[:,2]

    % clip data to clipping radius
    r = sqrt.(x.^2 + y.^2) % Euclidian distance
    i = r .> clip
    x[i] .= NaN
    y[i] .= NaN

end % function points_ellipse
end
