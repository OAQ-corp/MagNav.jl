% Auto-generated from src/eval_filt.jl
% Original Julia signature: function plot_filt_err(traj::Traj, filt_out::FILTout, crlb_out::CRLBout; dpi::Int        = 200, Nmax::Int       = 5000, plot_vel::Bool  = false, show_plot::Bool = true, save_plot::Bool = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_filt_err(traj, filt_out, crlb_out, varargin)
    out = [];
% TODO(Julia->MATLAB): dpi::Int        = 200,
% TODO(Julia->MATLAB): Nmax::Int       = 5000,
% TODO(Julia->MATLAB): plot_vel::Bool  = false,
% TODO(Julia->MATLAB): show_plot::Bool = true,
% TODO(Julia->MATLAB): save_plot::Bool = false)

% TODO(Julia->MATLAB): i  = downsample(1:traj.N,Nmax)
% TODO(Julia->MATLAB): tt = (traj.tt(i) .- traj.tt(i)[1]) / 60

    p1 = plot(xlab="time [min]",ylab="northing error [m]",dpi=dpi)
% TODO(Julia->MATLAB): plot!(p1,tt, filt_out.n_err(i),lab="filter error",lc=:black,lw=2)
% TODO(Julia->MATLAB): plot!(p1,tt, filt_out.n_std(i),lab="filter 1-σ",lc=:blue)
% TODO(Julia->MATLAB): plot!(p1,tt,-filt_out.n_std(i),lab=false,lc=:blue)
% TODO(Julia->MATLAB): plot!(p1,tt, crlb_out.n_std(i),lab="CRLB 1-σ",lc=:red,ls=:dash)
% TODO(Julia->MATLAB): plot!(p1,tt,-crlb_out.n_std(i),lab=false,lc=:red,ls=:dash)
    show_plot && display(p1)
    save_plot && png(p1,"northing_error.png")

    p2 = plot(xlab="time [min]",ylab="easting error [m]",dpi=dpi)
% TODO(Julia->MATLAB): plot!(p2,tt, filt_out.e_err(i),lab="filter error",lc=:black,lw=2)
% TODO(Julia->MATLAB): plot!(p2,tt, filt_out.e_std(i),lab="filter 1-σ",lc=:blue)
% TODO(Julia->MATLAB): plot!(p2,tt,-filt_out.e_std(i),lab=false,lc=:blue)
% TODO(Julia->MATLAB): plot!(p2,tt, crlb_out.e_std(i),lab="CRLB 1-σ",lc=:red,ls=:dash)
% TODO(Julia->MATLAB): plot!(p2,tt,-crlb_out.e_std(i),lab=false,lc=:red,ls=:dash)
    show_plot && display(p2)
    save_plot && png(p2,"easting_error.png")

    if plot_vel

        p3 = plot(xlab="time [min]",ylab="north velocity error [m/s]",dpi=dpi) % , ylim=(-10,10))
% TODO(Julia->MATLAB): plot!(p3,tt, filt_out.vn_err(i),lab="filter error",lc=:black,lw=2)
% TODO(Julia->MATLAB): plot!(p3,tt, filt_out.vn_std(i),lab="filter 1-σ",lc=:blue)
% TODO(Julia->MATLAB): plot!(p3,tt,-filt_out.vn_std(i),lab=false,lc=:blue)
        show_plot && display(p3)
        save_plot && png(p3,"north_velocity_error.png")

        p4 = plot(xlab="time [min]",ylab="east velocity error [m/s]",dpi=dpi) % , ylim=(-10,10))
% TODO(Julia->MATLAB): plot!(p4,tt, filt_out.ve_err(i),lab="filter error",lc=:black,lw=2)
% TODO(Julia->MATLAB): plot!(p4,tt, filt_out.ve_std(i),lab="filter 1-σ",lc=:blue)
% TODO(Julia->MATLAB): plot!(p4,tt,-filt_out.ve_std(i),lab=false,lc=:blue)
        show_plot && display(p4)
        save_plot && png(p4,"east_velocity_error.png")

    end
end
