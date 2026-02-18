% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_correlation(xyz::XYZ, xfeature::Symbol = :mag_1_c, yfeature::Symbol = :mag_1_uc, ind              = trues(xyz.traj.N);
% Mechanical conversion draft: review before production use.
function out = plot_correlation__ovl2(xyz, xfeature, yfeature, ind)
                          xfeature::Symbol = :mag_1_c,
                          yfeature::Symbol = :mag_1_uc,
                          ind              = trues(xyz.traj.N);
                          lim::Real        = 0,
                          dpi::Int         = 200,
                          show_plot::Bool  = true,
                          save_plot::Bool  = false,
                          plot_png::String = "$xfeature-$yfeature.png",
                          silent::Bool     = true)
    x = getfield(xyz,xfeature)[ind]
    y = getfield(xyz,yfeature)[ind]
    plot_correlation(x,y,xfeature,yfeature;
                     lim       = lim,
                     dpi       = dpi,
                     show_plot = show_plot,
                     save_plot = save_plot,
                     plot_png  = plot_png,
                     silent    = silent)
end % function plot_correlation
end
