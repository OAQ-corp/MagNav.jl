% Auto-generated from src/eval_filt.jl
% Original Julia signature: function eval_crlb(traj::Traj, crlb_P::Array)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function crlb_out = eval_crlb(traj, crlb_P)
    crlb_out = [];

    N = traj.N
    N_fields = length(fieldnames(CRLBout))
% TODO(Julia->MATLAB): crlb_out = CRLBout((zeros(N) for _ = 1:N_fields)...)

    crlb_out.lat_std  = sqrt(crlb_P(1,1,:))
    crlb_out.lon_std  = sqrt(crlb_P(2,2,:))
    crlb_out.alt_std  = sqrt(crlb_P(3,3,:))
    crlb_out.vn_std   = sqrt(crlb_P(4,4,:))
    crlb_out.ve_std   = sqrt(crlb_P(5,5,:))
    crlb_out.vd_std   = sqrt(crlb_P(6,6,:))
    crlb_out.tn_std   = sqrt(crlb_P(7,7,:))
    crlb_out.te_std   = sqrt(crlb_P(8,8,:))
    crlb_out.td_std   = sqrt(crlb_P(9,9,:))
    crlb_out.fogm_std = sqrt(crlb_P(18,18,:))

    crlb_out.n_std    = dlat2dn(crlb_out.lat_std,traj.lat)
    crlb_out.e_std    = dlon2de(crlb_out.lon_std,traj.lat)

    crlb_DRMS = round(Int,sqrt(mean(crlb_out.n_std.^2+crlb_out.e_std.^2)))
% TODO(Julia->MATLAB): @info("CRLB DRMS error = $crlb_DRMS m")

% return (crlb_out)
end % function eval_crlb
end
