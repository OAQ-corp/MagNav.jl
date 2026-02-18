% Auto-generated from src/baseline_plots.jl
% Original Julia signature: function plot_PSD(x::Vector, fs=10; window::Function  = hamming, dpi::Int          = 200, show_plot::Bool   = true, save_plot::Bool   = false, plot_png::String  = "PSD.png")
% Mechanical conversion draft: review before production use.
function p1 = plot_PSD(x, fs, varargin)
                  window::Function  = hamming,
                  dpi::Int          = 200,
                  show_plot::Bool   = true,
                  save_plot::Bool   = false,
                  plot_png::String  = "PSD.png")

    p = welch_pgram(x,fs=fs,window=window)

    p1 = plot(p.freq,pow2db.(p.power),lab="",dpi=dpi,
              xlab="frequency [Hz]",ylab="power/frequency [dB/Hz]")

    show_plot && display(p1)
    save_plot && png(p1,plot_png)

end % function plot_PSD
end
