% Auto-generated from src/analysis_util.jl
% Original Julia signature: function filter_events!(flight::Symbol, df_event::DataFrame; keyword::String = "", tt_lim::Tuple   = ())
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function nothing = filter_events_bang(flight, df_event, varargin)
    nothing = [];
% TODO(Julia->MATLAB): keyword::String = "",
% TODO(Julia->MATLAB): tt_lim::Tuple   = ())
    ind = Symbol(df_event.flight) == flight
    (t_start,t_end) = tt_lim == () ? extrema(df_event.tt(ind)) : tt_lim
% TODO(Julia->MATLAB): filter!(:flight => f -> (Symbol(f) == flight), df_event)
% TODO(Julia->MATLAB): filter!(:tt     => t -> (t_start <= t <= t_end), df_event)
% TODO(Julia->MATLAB): filter!(:event  => e -> occursin(String(keyword),lowercase(e)), df_event)
% return ([])
end % function filter_events!
end
