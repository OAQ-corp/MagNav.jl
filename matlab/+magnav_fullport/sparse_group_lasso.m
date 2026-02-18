% Auto-generated from src/analysis_util.jl
% Original Julia signature: function sparse_group_lasso(weights::Params, α=1)
% Mechanical conversion draft: review before production use.
function out = sparse_group_lasso(weights, f__)
                α *norm(weights[1][:,i],2) for i in axes(weights[1],2)])
end % function sparse_group_lasso
end
