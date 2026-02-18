% Auto-generated from src/map_functions.jl
% Original Julia signature: function plot_events!(p1::Plot, t::Real, lab::String = ""; legend::Symbol = :outertopright)
% Mechanical conversion draft: review before production use.
function nothing = plot_events_bang(p1, t, lab, varargin)
                      legend::Symbol = :outertopright)
    plot!(p1,[t],lab=lab,legend=legend,lc=:red,ls=:dash,lt=:vline,lw=1)
end % function plot_events!
end
