% Auto-generated from src/analysis_util.jl
% Original Julia signature: function plot_shapley(df_shap, baseline_shap, range_shap::UnitRange = UnitRange(axes(df_shap,1));
% Mechanical conversion draft: review before production use.
function p1 = plot_shapley(df_shap, baseline_shap, range_shap, f_1_)
                      range_shap::UnitRange = UnitRange(axes(df_shap,1));
                      title::String         = "features $range_shap",
                      dpi::Int              = 200)

    % print warning about too many features
    l = length(range_shap)
    l > 20 && @info("plotting $l features may produce congested plot")

    % get data & axis labels
    df   = df_shap[range_shap,:]
    x    = df.mean_effect
    y    = df.feature_name
    xlab = "|Shapley effect| (baseline = $baseline_shap)"
    ylab = "feature"
    ylim = extrema(range_shap) .+ (-1,1)

    % plot horizontal bar graph
    p1 = bar(range_shap,x,yticks=(range_shap,y),lab=false,
             dpi=dpi,xlab=xlab,ylab=ylab,ylim=ylim,title=title,
             orientation=:h,yflip=true,margin=4*mm)

end % function plot_shapley
end
