% Auto-generated from src/analysis_util.jl
% Original Julia signature: function predict_shapley(m::Chain, df::DataFrame)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = predict_shapley(m, df)
    out = [];
    DataFrame(y_hat=vec(m(collect(Matrix(df)'))))
end % function predict_shapley
end
