% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_correlation(xyz::XYZ, xfeature::Symbol = :mag_1_c, yfeature::Symbol = :mag_1_uc, ind              = trues(xyz.traj.N);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_correlation__ovl2(xyz, xfeature, yfeature, ind)
    out = [];
% TODO(Julia->MATLAB): xfeature::Symbol = :mag_1_c,
% TODO(Julia->MATLAB): yfeature::Symbol = :mag_1_uc,
                          ind              = trues(xyz.traj.N);
% TODO(Julia->MATLAB): lim::Real        = 0,
% TODO(Julia->MATLAB): dpi::Int         = 200,
% TODO(Julia->MATLAB): show_plot::Bool  = true,
% TODO(Julia->MATLAB): save_plot::Bool  = false,
% TODO(Julia->MATLAB): plot_png::String = "$xfeature-$yfeature.png",
% TODO(Julia->MATLAB): silent::Bool     = true)
% TODO(Julia->MATLAB): x = getfield(xyz,xfeature)[ind]
% TODO(Julia->MATLAB): y = getfield(xyz,yfeature)[ind]
    plot_correlation(x,y,xfeature,yfeature;
                     lim       = lim,
                     dpi       = dpi,
                     show_plot = show_plot,
                     save_plot = save_plot,
                     plot_png  = plot_png,
                     silent    = silent)
end % function plot_correlation
end
