% Auto-generated from src/analysis_util.jl
% Original Julia signature: function eval_shapley(m::Chain, x, features::Vector{Symbol}, N::Int      = min(10000,size(x,1)),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [df_shap, baseline_shap] = eval_shapley(m, x, features, N, size_x, f_1_)
    df_shap = [];
% TODO(Julia->MATLAB): N::Int      = min(10000,size(x,1)),
% TODO(Julia->MATLAB): num_mc::Int = 10)

% TODO(Julia->MATLAB): seed!(2) % for reproducibility

    % put data matrix into DataFrame
    df = DataFrame(x,features)

    % compute stochastic Shapley values
% TODO(Julia->MATLAB): df_temp = shap(explain          = df(shuffle(axes(df,1))[1:N),:],
                   reference        = df,
                   model            = m,
                   predict_function = predict_shapley,
                   sample_size      = num_mc,
                   seed             = 2)

    % setup output DataFrame
% TODO(Julia->MATLAB): df_shap = combine(groupby(df_temp, [:feature_name]),
% TODO(Julia->MATLAB): :shap_effect => (x -> mean(abs(x))) => :mean_effect)
% TODO(Julia->MATLAB): df_shap = sort(df_shap, order(:mean_effect, rev=true))
    baseline_shap = round(df_temp.intercept(1), digits=2)

% return (df_shap, baseline_shap)
end % function eval_shapley
end
