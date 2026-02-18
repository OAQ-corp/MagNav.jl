% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_spectrogram(x::Vector, fs=10; window::Function  = hamming, dpi::Int          = 200, show_plot::Bool   = true, save_plot::Bool   = false, plot_png::String  = "spectrogram.png")
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = plot_spectrogram(x, fs, varargin)
    p1 = [];
% TODO(Julia->MATLAB): window::Function  = hamming,
% TODO(Julia->MATLAB): dpi::Int          = 200,
% TODO(Julia->MATLAB): show_plot::Bool   = true,
% TODO(Julia->MATLAB): save_plot::Bool   = false,
% TODO(Julia->MATLAB): plot_png::String  = "spectrogram.png")

    s = spectrogram(x;fs=fs,window=window)

    p1 = heatmap(s.time,s.freq,pow2db(s.power),dpi=dpi,
                 xguide="time [s]",yguide="frequency [Hz]")

    show_plot && display(p1)
    save_plot && png(p1,plot_png)

% return (p1)
end % function plot_spectrogram
end
