% Auto-generated from src/analysis_util.jl
% Original Julia signature: function predict_shapley(m::Chain, df::DataFrame)
% Mechanical conversion draft: review before production use.
function out = predict_shapley(m, df)
    DataFrame(y_hat=vec(m(collect(Matrix(df)'))))
end % function predict_shapley
end
