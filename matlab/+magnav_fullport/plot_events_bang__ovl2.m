% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_events!(p1::Plot, flight::Symbol,  df_event::DataFrame; keyword::String = "", show_lab::Bool  = true, t0::Real        = 0, t_units::Symbol = :sec, legend::Symbol  = :outertopright)
% Mechanical conversion draft: review before production use.
function out = plot_events_bang__ovl2(p1, flight, df_event, varargin)
                      keyword::String = "",
                      show_lab::Bool  = true,
                      t0::Real        = 0,
                      t_units::Symbol = :sec,
                      legend::Symbol  = :outertopright)
    tt_lim = xlims(p1) .+ t0
    t_units == :min && (tt_lim = 60 .* tt_lim)
    df = filter_events(flight,df_event;keyword=keyword,tt_lim=tt_lim)
    for i in axes(df,1)
        lab = show_lab ? String(df[i,:event]) : ""
        t   = df[i,:tt]
        t_units == :min && (t = t/60)
        plot_events!(p1,t-t0,lab;legend=legend)
    end
end
