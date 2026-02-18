% Auto-generated from src/analysis_util.jl
% Original Julia signature: function eval_shapley(m::Chain, x, features::Vector{Symbol}, N::Int      = min(10000,size(x,1)),
% Mechanical conversion draft: review before production use.
function [df_shap, baseline_shap] = eval_shapley(m, x, features, N, size_x, f_1_)
                      N::Int      = min(10000,size(x,1)),
                      num_mc::Int = 10)

    seed!(2) % for reproducibility

    % put data matrix into DataFrame
    df = DataFrame(x,features)

    % compute stochastic Shapley values
    df_temp = shap(explain          = df[shuffle(axes(df,1))[1:N],:],
                   reference        = df,
                   model            = m,
                   predict_function = predict_shapley,
                   sample_size      = num_mc,
                   seed             = 2)

    % setup output DataFrame
    df_shap = combine(groupby(df_temp, [:feature_name]),
              :shap_effect => (x -> mean(abs.(x))) => :mean_effect)
    df_shap = sort(df_shap, order(:mean_effect, rev=true))
    baseline_shap = round(df_temp.intercept[1], digits=2)

end % function eval_shapley
end
