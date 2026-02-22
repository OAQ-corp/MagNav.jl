% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_events(p1::Plot, flight::Symbol,  df_event::DataFrame; keyword::String = "", show_lab::Bool  = true, t0::Real        = 0, t_units::Symbol = :sec, legend::Symbol  = :outertopright)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p2 = plot_events(p1, flight, df_event, varargin)
    p2 = [];
% TODO(Julia->MATLAB): keyword::String = "",
% TODO(Julia->MATLAB): show_lab::Bool  = true,
% TODO(Julia->MATLAB): t0::Real        = 0,
% TODO(Julia->MATLAB): t_units::Symbol = :sec,
% TODO(Julia->MATLAB): legend::Symbol  = :outertopright)
    p2 = deepcopy(p1)
% TODO(Julia->MATLAB): plot_events!(p2,flight,df_event;
                 keyword  = keyword,
                 show_lab = show_lab,
                 t0       = t0,
                 t_units  = t_units,
                 legend   = legend)
% return (p2)
end % function plot_events
end
