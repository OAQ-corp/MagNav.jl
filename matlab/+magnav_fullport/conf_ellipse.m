% Auto-generated from src/eval_filt.jl
% Original Julia signature: function conf_ellipse(P; μ                    = zeros(eltype(P),2),
% Mechanical conversion draft: review before production use.
function p1 = conf_ellipse(P, varargin)
                      μ                    = zeros(eltype(P),2),
                      conf                 = 0.95,
                      clip                 = Inf,
                      n::Int               = 61,
                      lim                  = nothing,
                      margin::Int          = 2,
                      lab::String          = "[m]",
                      axis::Bool           = true,
                      plot_eigax::Bool     = false,
                      bg_color::Symbol     = :white,
                      ce_color::Symbol     = :black,
                      b_e::AbstractBackend = gr())
    b_e % backend
    p1 = plot()
    conf_ellipse!(p1,P;
                  μ          = μ,
                  conf       = conf,
                  clip       = clip,
                  n          = n,
                  lim        = lim,
                  margin     = margin,
                  lab        = lab,
                  axis       = axis,
                  plot_eigax = plot_eigax,
                  bg_color   = bg_color,
                  ce_color   = ce_color,
                  b_e        = b_e)
end % function conf_ellipse
end
