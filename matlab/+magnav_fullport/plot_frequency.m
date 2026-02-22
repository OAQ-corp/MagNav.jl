% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_frequency(xyz::XYZ; ind                = trues(xyz.traj.N),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = plot_frequency(xyz, varargin)
    p1 = [];
                        ind                = trues(xyz.traj.N),
% TODO(Julia->MATLAB): field::Symbol      = :mag_1_uc,
% TODO(Julia->MATLAB): freq_type::Symbol  = :PSD,
% TODO(Julia->MATLAB): detrend_data::Bool = true,
% TODO(Julia->MATLAB): window::Function   = hamming,
% TODO(Julia->MATLAB): dpi::Int           = 200,
% TODO(Julia->MATLAB): show_plot::Bool    = true,
% TODO(Julia->MATLAB): save_plot::Bool    = false,
% TODO(Julia->MATLAB): plot_png::String   = "PSD.png")

% TODO(Julia->MATLAB): x = getfield(xyz,field)[ind]

    detrend_data && (x = detrend(x))

    fs = 1/xyz.traj.dt

% TODO(Julia->MATLAB): f = freq_type in [:PSD,:psd] ? plot_PSD : plot_spectrogram

    p1 = f(x,fs;
           window    = window,
           dpi       = dpi,
           show_plot = show_plot,
           save_plot = save_plot,
           plot_png  = plot_png)

% return (p1)
end % function plot_frequency
end
