% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_frequency(xyz::XYZ; ind                = trues(xyz.traj.N),
% Mechanical conversion draft: review before production use.
function p1 = plot_frequency(xyz, varargin)
                        ind                = trues(xyz.traj.N),
                        field::Symbol      = :mag_1_uc,
                        freq_type::Symbol  = :PSD,
                        detrend_data::Bool = true,
                        window::Function   = hamming,
                        dpi::Int           = 200,
                        show_plot::Bool    = true,
                        save_plot::Bool    = false,
                        plot_png::String   = "PSD.png")

    x = getfield(xyz,field)[ind]

    detrend_data && (x = detrend(x))

    fs = 1/xyz.traj.dt

    f = freq_type in [:PSD,:psd] ? plot_PSD : plot_spectrogram

    p1 = f(x,fs;
           window    = window,
           dpi       = dpi,
           show_plot = show_plot,
           save_plot = save_plot,
           plot_png  = plot_png)

end % function plot_frequency
end
