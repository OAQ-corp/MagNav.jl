% Auto-generated from src/mpf.jl
% Original Julia signature: function filter_exit(Pl_out, Pn_out, t::Int, converge::Bool = true)
% Mechanical conversion draft: review before production use.
function P_out = filter_exit(Pl_out, Pn_out, t, converge)
    nxl   = size(Pl_out,1)
    nxn   = size(Pn_out,1)
    nx    = nxl+nxn
    N     = size(Pl_out,3)
    P_out = zeros(eltype(Pl_out),nx,nx,N) % covariance matrix
    P_out[1:nxn,1:nxn,:]         = Pn_out % non-linear portion
    P_out[nxn+1:end,nxn+1:end,:] = Pl_out % linear portion
    converge || @info("filter diverged, particle weights ~0 at time step $t")
end % function filter_exit
end
