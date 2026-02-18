% Auto-generated from src/analysis_util.jl
% Original Julia signature: function filter_events!(flight::Symbol, df_event::DataFrame; keyword::String = "", tt_lim::Tuple   = ())
% Mechanical conversion draft: review before production use.
function nothing = filter_events_bang(flight, df_event, varargin)
                        keyword::String = "",
                        tt_lim::Tuple   = ())
    ind = Symbol.(df_event.flight) .== flight
    (t_start,t_end) = tt_lim == () ? extrema(df_event.tt[ind]) : tt_lim
    filter!(:flight => f -> (Symbol(f) == flight), df_event)
    filter!(:tt     => t -> (t_start <= t <= t_end), df_event)
    filter!(:event  => e -> occursin(String(keyword),lowercase(e)), df_event)
end % function filter_events!
end
