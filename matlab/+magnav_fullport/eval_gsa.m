% Auto-generated from src/analysis_util.jl
% Original Julia signature: function eval_gsa(m::Chain, x, n::Int = min(10000,size(x,1)))
% Mechanical conversion draft: review before production use.
function means = eval_gsa(m, x, n, size_x, f_1__)

    seed!(2) % for reproducibility

    method      = Morris(relative_scale=true,num_trajectory=n)
    param_range = vec(extrema(x,dims=1))
    means       = vec(gsa(m,method,param_range;samples=n).means)
    % %* note: produces Float32 warning even if param_range is Float32

end % function eval_gsa
end
