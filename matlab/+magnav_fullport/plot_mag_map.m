% Auto-generated from src/eval_filt.jl
% Original Julia signature: function plot_mag_map(path::Path, mag, itp_mapS; lab::String        = "magnetometer", order::Symbol      = :magmap, dpi::Int           = 200, Nmax::Int          = 5000, detrend_data::Bool = true, show_plot::Bool    = true, save_plot::Bool    = false, plot_png::String   = "mag_vs_map.png")
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_mag_map(path, mag, itp_mapS, varargin)
    out = [];
% TODO(Julia->MATLAB): lab::String        = "magnetometer",
% TODO(Julia->MATLAB): order::Symbol      = :magmap,
% TODO(Julia->MATLAB): dpi::Int           = 200,
% TODO(Julia->MATLAB): Nmax::Int          = 5000,
% TODO(Julia->MATLAB): detrend_data::Bool = true,
% TODO(Julia->MATLAB): show_plot::Bool    = true,
% TODO(Julia->MATLAB): save_plot::Bool    = false,
% TODO(Julia->MATLAB): plot_png::String   = "mag_vs_map.png")

% TODO(Julia->MATLAB): i  = downsample(1:path.N,Nmax)
% TODO(Julia->MATLAB): tt = (path.tt(i) .- path.tt(i)[1]) / 60

    map_val = itp_mapS(path.lat(i),path.lon(i),path.alt(i))
    mag_val = detrend_data ? detrend(mag(i) ) : mag(i)
    map_val = detrend_data ? detrend(map_val) : map_val

    p1 = plot(xlab="time [min]",ylab="magnetic field [nT]",dpi=dpi)
% TODO(Julia->MATLAB): if order == :magmap
% TODO(Julia->MATLAB): plot!(p1,tt,mag_val,lab=lab)
% TODO(Julia->MATLAB): plot!(p1,tt,map_val,lab="anomaly map")
% TODO(Julia->MATLAB): elseif order == :mapmag
% TODO(Julia->MATLAB): plot!(p1,tt,map_val,lab="anomaly map")
% TODO(Julia->MATLAB): plot!(p1,tt,mag_val,lab=lab)
    else
% TODO(Julia->MATLAB): error("order $order not defined")
    end
end
