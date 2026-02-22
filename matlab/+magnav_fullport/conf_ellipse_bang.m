% Auto-generated from src/eval_filt.jl
% Original Julia signature: function conf_ellipse!(p1::Plot, P; μ                    = zeros(eltype(P),2),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = conf_ellipse_bang(p1, P, varargin)
    out = [];
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

    (eigval,eigvec) = eigen(P)
    eigax = I*sqrt(Diagonal(eigval)) * eigvec'

    % check arguments
    xlim = ylim = lim isa Nothing  ? lim : (-lim,lim)
    xlab = ylab = axis             ? lab : ""
    assert all(real(eigval) .> 0) "P is not positive definite"
% TODO(Julia->MATLAB): assert size(P) == (2,2)       "P is size $(size(P)) ≂̸ (2,2)"
% TODO(Julia->MATLAB): assert length(μ) == 2         "μ is length $(length(μ)) ≂̸ 2"
% TODO(Julia->MATLAB): assert 0 < conf < 1           "conf is not 0 < $conf < 1"

    k  = sqrt(chisq_q(conf,2)) % compute quantile for desired percentile
    b_e % backend
    if lim isa Nothing
% TODO(Julia->MATLAB): plot!(p1,xlab=xlab,ylab=ylab,
% TODO(Julia->MATLAB): legend=false,aspect_ratio=:equal,margin=margin*mm,
              axis=axis,xticks=axis,yticks=axis,grid=axis,bg=bg_color)
    else
% TODO(Julia->MATLAB): plot!(p1,xlim=xlim,ylim=ylim,xlab=xlab,ylab=ylab,
% TODO(Julia->MATLAB): legend=false,aspect_ratio=:equal,margin=margin*mm,
              axis=axis,xticks=axis,yticks=axis,grid=axis,bg=bg_color)
    end
end
