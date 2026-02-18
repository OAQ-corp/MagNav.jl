% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_spectrogram(x::Vector, fs=10; window::Function  = hamming, dpi::Int          = 200, show_plot::Bool   = true, save_plot::Bool   = false, plot_png::String  = "spectrogram.png")
% Mechanical conversion draft: review before production use.
function p1 = plot_spectrogram(x, fs, varargin)
                          window::Function  = hamming,
                          dpi::Int          = 200,
                          show_plot::Bool   = true,
                          save_plot::Bool   = false,
                          plot_png::String  = "spectrogram.png")

    s = spectrogram(x;fs=fs,window=window)

    p1 = heatmap(s.time,s.freq,pow2db.(s.power),dpi=dpi,
                 xguide="time [s]",yguide="frequency [Hz]")

    show_plot && display(p1)
    save_plot && png(p1,plot_png)

end % function plot_spectrogram
end
