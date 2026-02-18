% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_correlation_matrix(xyz::XYZ, ind = trues(xyz.traj.N),
% Mechanical conversion draft: review before production use.
function p1 = plot_correlation_matrix__ovl2(xyz, ind)
                                 features_setup::Vector{Symbol} = [:mag_1_uc,:TL_A_flux_a];
                                 terms             = [:permanent],
                                 sub_diurnal::Bool = false,
                                 sub_igrf::Bool    = false,
                                 bpf_mag::Bool     = false,
                                 dpi::Int          = 200,
                                 Nmax::Int         = 1000,
                                 show_plot::Bool   = true,
                                 save_plot::Bool   = false,
                                 plot_png::String  = "correlation_matrix.png")

    (x,_,features,_) = get_x(xyz,ind,features_setup;
                             terms       = terms,
                             sub_diurnal = sub_diurnal,
                             sub_igrf    = sub_igrf,
                             bpf_mag     = bpf_mag)

    p1 = plot_correlation_matrix(x,features;
                                 dpi       = dpi,
                                 Nmax      = Nmax,
                                 show_plot = show_plot,
                                 save_plot = save_plot,
                                 plot_png  = plot_png)

end % function plot_correlation_matrix
end
