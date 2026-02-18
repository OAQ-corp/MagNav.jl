% Auto-generated from src/eval_filt.jl
% Original Julia signature: function plot_filt!(p1::Plot, traj::Traj, ins::INS, filt_out::FILTout; dpi::Int        = 200, Nmax::Int       = 5000, show_plot::Bool = true, save_plot::Bool = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function nothing = plot_filt_bang(p1, traj, ins, filt_out, varargin)
    nothing = [];
% TODO(Julia->MATLAB): dpi::Int        = 200,
% TODO(Julia->MATLAB): Nmax::Int       = 5000,
% TODO(Julia->MATLAB): show_plot::Bool = true,
% TODO(Julia->MATLAB): save_plot::Bool = false)

% TODO(Julia->MATLAB): i    = downsample(1:traj.N,Nmax)
    lon  = rad2deg([traj.lon;ins.lon;filt_out.lon])
    lat  = rad2deg([traj.lat;ins.lat;filt_out.lat])
    xlim = get_lim(lon,0.05)
    ylim = get_lim(lat,0.05)

% TODO(Julia->MATLAB): plot!(p1,xlab="longitude [deg]",ylab="latitude [deg]",dpi=dpi)
% TODO(Julia->MATLAB): plot!(p1,rad2deg(traj.lon(i))    ,rad2deg(traj.lat(i))    ,lab="GPS")
% TODO(Julia->MATLAB): plot!(p1,rad2deg(ins.lon(i))     ,rad2deg(ins.lat(i))     ,lab="INS")
% TODO(Julia->MATLAB): plot!(p1,rad2deg(filt_out.lon(i)),rad2deg(filt_out.lat(i)),lab="MagNav")
% TODO(Julia->MATLAB): plot!(p1,xlim=xlim,ylim=ylim)
    show_plot && display(p1)
    save_plot && png(p1,"flight_path.png")

% return ([])
end % function plot_filt!
end
