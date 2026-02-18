% Auto-generated from src/eval_filt.jl
% Original Julia signature: function plot_filt(p1::Plot, traj::Traj, ins::INS, filt_out::FILTout; dpi::Int        = 200, Nmax::Int       = 5000, plot_vel::Bool  = false, show_plot::Bool = true, save_plot::Bool = false)
% Mechanical conversion draft: review before production use.
function out = plot_filt(p1, traj, ins, filt_out, varargin)
                   dpi::Int        = 200,
                   Nmax::Int       = 5000,
                   plot_vel::Bool  = false,
                   show_plot::Bool = true,
                   save_plot::Bool = false)

    p2 = deepcopy(p1)
    plot_filt!(p2,traj,ins,filt_out;
               dpi       = dpi,
               Nmax      = Nmax,
               show_plot = show_plot,
               save_plot = save_plot)

    i  = downsample(1:traj.N,Nmax)
    tt = (traj.tt[i] .- traj.tt[i][1]) / 60

    p3 = plot(xlab="time [min]",ylab="latitude [deg]",dpi=dpi)
    plot!(p3,tt,rad2deg.(traj.lat[i])    ,lab="GPS")
    plot!(p3,tt,rad2deg.(ins.lat[i])     ,lab="INS")
    plot!(p3,tt,rad2deg.(filt_out.lat[i]),lab="MagNav")
    show_plot && display(p3)
    save_plot && png(p3,"latitude.png")

    p4 = plot(xlab="time [min]",ylab="longitude [deg]",dpi=dpi)
    plot!(p4,tt,rad2deg.(traj.lon[i])    ,lab="GPS")
    plot!(p4,tt,rad2deg.(ins.lon[i])     ,lab="INS")
    plot!(p4,tt,rad2deg.(filt_out.lon[i]),lab="MagNav")
    show_plot && display(p4)
    save_plot && png(p4,"longitude.png")

    if plot_vel
        p5 = plot(xlab="time [min]",ylab="north velocity [m/s]",dpi=dpi)
        plot!(p5,tt,traj.vn[i]    ,lab="GPS")
        plot!(p5,tt,ins.vn[i]     ,lab="INS")
        plot!(p5,tt,filt_out.vn[i],lab="MagNav")
        show_plot && display(p5)
        save_plot && png(p5,"north_velocity.png")

        p6 = plot(xlab="time [min]",ylab="east velocity [m/s]",dpi=dpi)
        plot!(p6,tt,traj.ve[i]    ,lab="GPS")
        plot!(p6,tt,ins.ve[i]     ,lab="INS")
        plot!(p6,tt,filt_out.ve[i],lab="MagNav")
        show_plot && display(p6)
        save_plot && png(p6,"east_velocity.png")
    end
end
