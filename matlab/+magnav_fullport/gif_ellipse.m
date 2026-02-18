% Auto-generated from src/eval_filt.jl
% Original Julia signature: function gif_ellipse(P, lat1 = deg2rad(45);
% Mechanical conversion draft: review before production use.
function out = gif_ellipse(P, lat1)
                     dt                   = 0.1,
                     di::Int              = 10,
                     speedup::Int         = 60,
                     conf_units::Symbol   = :m,
                     μ                    = zeros(eltype(P),2),
                     conf                 = 0.95,
                     clip                 = Inf,
                     n::Int               = 61,
                     lim                  = 500,
                     margin::Int          = 2,
                     axis::Bool           = true,
                     plot_eigax::Bool     = false,
                     bg_color::Symbol     = :white,
                     ce_color::Symbol     = :black,
                     b_e::AbstractBackend = gr(),
                     save_plot::Bool      = false,
                     ellipse_gif::String  = "conf_ellipse.gif")

    P  = units_ellipse(P;conf_units=conf_units,lat1=lat1)
    a1 = Animation()

    for i = 1:di:size(P,3)
        p1 = conf_ellipse(P[:,:,i];
                          μ          = μ,
                          conf       = conf,
                          clip       = clip,
                          n          = n,
                          lim        = lim,
                          margin     = margin,
                          axis       = axis,
                          plot_eigax = plot_eigax,
                          bg_color   = bg_color,
                          ce_color   = ce_color,
                          b_e        = b_e);
        frame(a1,p1);
    end
end
