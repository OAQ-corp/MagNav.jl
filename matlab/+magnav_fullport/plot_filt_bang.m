% Auto-generated from src/eval_filt.jl
% Original Julia signature: function plot_filt!(p1::Plot, traj::Traj, ins::INS, filt_out::FILTout; dpi::Int        = 200, Nmax::Int       = 5000, show_plot::Bool = true, save_plot::Bool = false)
% Mechanical conversion draft: review before production use.
function nothing = plot_filt_bang(p1, traj, ins, filt_out, varargin)
                    dpi::Int        = 200,
                    Nmax::Int       = 5000,
                    show_plot::Bool = true,
                    save_plot::Bool = false)

    i    = downsample(1:traj.N,Nmax)
    lon  = rad2deg.([traj.lon;ins.lon;filt_out.lon])
    lat  = rad2deg.([traj.lat;ins.lat;filt_out.lat])
    xlim = get_lim(lon,0.05)
    ylim = get_lim(lat,0.05)

    plot!(p1,xlab="longitude [deg]",ylab="latitude [deg]",dpi=dpi)
    plot!(p1,rad2deg.(traj.lon[i])    ,rad2deg.(traj.lat[i])    ,lab="GPS")
    plot!(p1,rad2deg.(ins.lon[i])     ,rad2deg.(ins.lat[i])     ,lab="INS")
    plot!(p1,rad2deg.(filt_out.lon[i]),rad2deg.(filt_out.lat[i]),lab="MagNav")
    plot!(p1,xlim=xlim,ylim=ylim)
    show_plot && display(p1)
    save_plot && png(p1,"flight_path.png")

end % function plot_filt!
end
