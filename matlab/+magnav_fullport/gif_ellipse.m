% Auto-generated from src/eval_filt.jl
% Original Julia signature: function gif_ellipse(P, lat1 = deg2rad(45);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = gif_ellipse(P, lat1)
    out = [];
                     dt                   = 0.1,
% TODO(Julia->MATLAB): di::Int              = 10,
% TODO(Julia->MATLAB): speedup::Int         = 60,
% TODO(Julia->MATLAB): conf_units::Symbol   = :m,
                     μ                    = zeros(eltype(P),2),
                     conf                 = 0.95,
                     clip                 = Inf,
% TODO(Julia->MATLAB): n::Int               = 61,
                     lim                  = 500,
% TODO(Julia->MATLAB): margin::Int          = 2,
% TODO(Julia->MATLAB): axis::Bool           = true,
% TODO(Julia->MATLAB): plot_eigax::Bool     = false,
% TODO(Julia->MATLAB): bg_color::Symbol     = :white,
% TODO(Julia->MATLAB): ce_color::Symbol     = :black,
% TODO(Julia->MATLAB): b_e::AbstractBackend = gr(),
% TODO(Julia->MATLAB): save_plot::Bool      = false,
% TODO(Julia->MATLAB): ellipse_gif::String  = "conf_ellipse.gif")

    P  = units_ellipse(P;conf_units=conf_units,lat1=lat1)
    a1 = Animation()

% TODO(Julia->MATLAB): for i = 1:di:size(P,3)
        p1 = conf_ellipse(P(:,:,i);
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
