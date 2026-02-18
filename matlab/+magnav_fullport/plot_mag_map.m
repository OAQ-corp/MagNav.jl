% Auto-generated from src/eval_filt.jl
% Original Julia signature: function plot_mag_map(path::Path, mag, itp_mapS; lab::String        = "magnetometer", order::Symbol      = :magmap, dpi::Int           = 200, Nmax::Int          = 5000, detrend_data::Bool = true, show_plot::Bool    = true, save_plot::Bool    = false, plot_png::String   = "mag_vs_map.png")
% Mechanical conversion draft: review before production use.
function out = plot_mag_map(path, mag, itp_mapS, varargin)
                      lab::String        = "magnetometer",
                      order::Symbol      = :magmap,
                      dpi::Int           = 200,
                      Nmax::Int          = 5000,
                      detrend_data::Bool = true,
                      show_plot::Bool    = true,
                      save_plot::Bool    = false,
                      plot_png::String   = "mag_vs_map.png")

    i  = downsample(1:path.N,Nmax)
    tt = (path.tt[i] .- path.tt[i][1]) / 60

    map_val = itp_mapS.(path.lat[i],path.lon[i],path.alt[i])
    mag_val = detrend_data ? detrend(mag[i] ) : mag[i]
    map_val = detrend_data ? detrend(map_val) : map_val

    p1 = plot(xlab="time [min]",ylab="magnetic field [nT]",dpi=dpi)
    if order == :magmap
        plot!(p1,tt,mag_val,lab=lab)
        plot!(p1,tt,map_val,lab="anomaly map")
    elseif order == :mapmag
        plot!(p1,tt,map_val,lab="anomaly map")
        plot!(p1,tt,mag_val,lab=lab)
    else
        error("order $order not defined")
    end
end
