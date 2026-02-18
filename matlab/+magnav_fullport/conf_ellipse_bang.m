% Auto-generated from src/eval_filt.jl
% Original Julia signature: function conf_ellipse!(p1::Plot, P; μ                    = zeros(eltype(P),2),
% Mechanical conversion draft: review before production use.
function out = conf_ellipse_bang(p1, P, varargin)
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

    (eigval,eigvec) = eigen(P)
    eigax = I*sqrt.(Diagonal(eigval)) * eigvec'

    % check arguments
    xlim = ylim = lim isa Nothing  ? lim : (-lim,lim)
    xlab = ylab = axis             ? lab : ""
    assert all(real(eigval) .> 0) "P is not positive definite"
    assert size(P) == (2,2)       "P is size $(size(P)) ≂̸ (2,2)"
    assert length(μ) == 2         "μ is length $(length(μ)) ≂̸ 2"
    assert 0 < conf < 1           "conf is not 0 < $conf < 1"

    k  = sqrt(chisq_q(conf,2)) % compute quantile for desired percentile
    b_e % backend
    if lim isa Nothing
        plot!(p1,xlab=xlab,ylab=ylab,
              legend=false,aspect_ratio=:equal,margin=margin*mm,
              axis=axis,xticks=axis,yticks=axis,grid=axis,bg=bg_color)
    else
        plot!(p1,xlim=xlim,ylim=ylim,xlab=xlab,ylab=ylab,
              legend=false,aspect_ratio=:equal,margin=margin*mm,
              axis=axis,xticks=axis,yticks=axis,grid=axis,bg=bg_color)
    end
end
