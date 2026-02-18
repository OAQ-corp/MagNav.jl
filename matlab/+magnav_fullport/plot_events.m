% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_events(p1::Plot, flight::Symbol,  df_event::DataFrame; keyword::String = "", show_lab::Bool  = true, t0::Real        = 0, t_units::Symbol = :sec, legend::Symbol  = :outertopright)
% Mechanical conversion draft: review before production use.
function p2 = plot_events(p1, flight, df_event, varargin)
                     keyword::String = "",
                     show_lab::Bool  = true,
                     t0::Real        = 0,
                     t_units::Symbol = :sec,
                     legend::Symbol  = :outertopright)
    p2 = deepcopy(p1)
    plot_events!(p2,flight,df_event;
                 keyword  = keyword,
                 show_lab = show_lab,
                 t0       = t0,
                 t_units  = t_units,
                 legend   = legend)
end % function plot_events
end
