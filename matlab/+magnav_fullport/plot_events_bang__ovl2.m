% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_events!(p1::Plot, flight::Symbol,  df_event::DataFrame; keyword::String = "", show_lab::Bool  = true, t0::Real        = 0, t_units::Symbol = :sec, legend::Symbol  = :outertopright)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plot_events_bang__ovl2(p1, flight, df_event, varargin)
    out = [];
% TODO(Julia->MATLAB): keyword::String = "",
% TODO(Julia->MATLAB): show_lab::Bool  = true,
% TODO(Julia->MATLAB): t0::Real        = 0,
% TODO(Julia->MATLAB): t_units::Symbol = :sec,
% TODO(Julia->MATLAB): legend::Symbol  = :outertopright)
    tt_lim = xlims(p1) .+ t0
% TODO(Julia->MATLAB): t_units == :min && (tt_lim = 60 .* tt_lim)
    df = filter_events(flight,df_event;keyword=keyword,tt_lim=tt_lim)
% TODO(Julia->MATLAB): for i in axes(df,1)
% TODO(Julia->MATLAB): lab = show_lab ? String(df(i,:event)) : ""
% TODO(Julia->MATLAB): t   = df(i,:tt)
% TODO(Julia->MATLAB): t_units == :min && (t = t/60)
% TODO(Julia->MATLAB): plot_events!(p1,t-t0,lab;legend=legend)
    end
end
