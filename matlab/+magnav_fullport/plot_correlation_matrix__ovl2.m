% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_correlation_matrix(xyz::XYZ, ind = trues(xyz.traj.N),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = plot_correlation_matrix__ovl2(xyz, ind)
    p1 = [];
% TODO(Julia->MATLAB): features_setup::Vector{Symbol} = [:mag_1_uc,:TL_A_flux_a];
% TODO(Julia->MATLAB): terms             = [:permanent],
% TODO(Julia->MATLAB): sub_diurnal::Bool = false,
% TODO(Julia->MATLAB): sub_igrf::Bool    = false,
% TODO(Julia->MATLAB): bpf_mag::Bool     = false,
% TODO(Julia->MATLAB): dpi::Int          = 200,
% TODO(Julia->MATLAB): Nmax::Int         = 1000,
% TODO(Julia->MATLAB): show_plot::Bool   = true,
% TODO(Julia->MATLAB): save_plot::Bool   = false,
% TODO(Julia->MATLAB): plot_png::String  = "correlation_matrix.png")

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

% return (p1)
end % function plot_correlation_matrix
end
