% Auto-generated from src/eval_filt.jl
% Original Julia signature: function plot_mag_map_err(path::Path, mag, itp_mapS; lab::String        = "", dpi::Int           = 200, Nmax::Int          = 5000, detrend_data::Bool = true, show_plot::Bool    = true, save_plot::Bool    = false, plot_png::String   = "mag_map_err.png")
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = plot_mag_map_err(path, mag, itp_mapS, varargin)
    p1 = [];
% TODO(Julia->MATLAB): lab::String        = "",
% TODO(Julia->MATLAB): dpi::Int           = 200,
% TODO(Julia->MATLAB): Nmax::Int          = 5000,
% TODO(Julia->MATLAB): detrend_data::Bool = true,
% TODO(Julia->MATLAB): show_plot::Bool    = true,
% TODO(Julia->MATLAB): save_plot::Bool    = false,
% TODO(Julia->MATLAB): plot_png::String   = "mag_map_err.png")

% TODO(Julia->MATLAB): i  = downsample(1:path.N,Nmax)
% TODO(Julia->MATLAB): tt = (path.tt(i) .- path.tt(i)[1]) / 60

    l  = detrend_data ? "detrended " : ""
    p1 = plot(xlab="time [min]",ylab=l*"magnetic signal error [nT]",dpi=dpi)

    f = detrend_data ? detrend : x -> x

    map_val = itp_mapS(path.lat(i),path.lon(i),path.alt(i))

% TODO(Julia->MATLAB): plot!(p1,tt,f(mag(i) - map_val),lab=lab)

    show_plot && display(p1)
    save_plot && png(p1,plot_png)

	err = round(std(mag(i) - map_val),digits=2)
% TODO(Julia->MATLAB): @info("mag-map error standard deviation = $err nT")

% return (p1)
end % function plot_mag_map_err
end
