% Auto-generated from src/analysis_util.jl
% Original Julia signature: function filter_events(flight::Symbol, df_event::DataFrame; keyword::String = "", tt_lim::Tuple   = ())
% Mechanical conversion draft: review before production use.
function df_event = filter_events(flight, df_event, varargin)
                       keyword::String = "",
                       tt_lim::Tuple   = ())
    df_event = deepcopy(df_event)
    filter_events!(flight,df_event;keyword=keyword,tt_lim=tt_lim)
end % function filter_events
end
