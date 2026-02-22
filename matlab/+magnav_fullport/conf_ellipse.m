% Auto-generated from src/eval_filt.jl
% Original Julia signature: function conf_ellipse(P; μ                    = zeros(eltype(P),2),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function p1 = conf_ellipse(P, varargin)
    p1 = [];
                      μ                    = zeros(eltype(P),2),
                      conf                 = 0.95,
                      clip                 = Inf,
% TODO(Julia->MATLAB): n::Int               = 61,
                      lim                  = [],
% TODO(Julia->MATLAB): margin::Int          = 2,
% TODO(Julia->MATLAB): lab::String          = "[m]",
% TODO(Julia->MATLAB): axis::Bool           = true,
% TODO(Julia->MATLAB): plot_eigax::Bool     = false,
% TODO(Julia->MATLAB): bg_color::Symbol     = :white,
% TODO(Julia->MATLAB): ce_color::Symbol     = :black,
% TODO(Julia->MATLAB): b_e::AbstractBackend = gr())
    b_e % backend
    p1 = plot()
% TODO(Julia->MATLAB): conf_ellipse!(p1,P;
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
% return (p1)
end % function conf_ellipse
end
