% Auto-generated from src/analysis_util.jl
% Original Julia signature: function plot_shapley(df_shap, baseline_shap, range_shap::UnitRange = UnitRange(axes(df_shap,1));
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = plot_shapley(df_shap, baseline_shap, range_shap, f_1_)
    p1 = [];
% TODO(Julia->MATLAB): range_shap::UnitRange = UnitRange(axes(df_shap,1));
% TODO(Julia->MATLAB): title::String         = "features $range_shap",
% TODO(Julia->MATLAB): dpi::Int              = 200)

    % print warning about too many features
    l = length(range_shap)
% TODO(Julia->MATLAB): l > 20 && @info("plotting $l features may produce congested plot")

    % get data & axis labels
    df   = df_shap(range_shap,:)
    x    = df.mean_effect
    y    = df.feature_name
% TODO(Julia->MATLAB): xlab = "|Shapley effect| (baseline = $baseline_shap)"
    ylab = "feature"
    ylim = extrema(range_shap) .+ (-1,1)

    % plot horizontal bar graph
    p1 = bar(range_shap,x,yticks=(range_shap,y),lab=false,
             dpi=dpi,xlab=xlab,ylab=ylab,ylim=ylim,title=title,
% TODO(Julia->MATLAB): orientation=:h,yflip=true,margin=4*mm)

% return (p1)
end % function plot_shapley
end
