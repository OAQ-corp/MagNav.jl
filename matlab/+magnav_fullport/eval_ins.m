% Auto-generated from src/eval_filt.jl
% Original Julia signature: function eval_ins(traj::Traj, ins::INS)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = eval_ins(traj, ins)
    out = [];

    % not doing vn,ve,vd,tn,te,td,ax,ay,az,gx,gy,gz

    N = traj.N
    N_fields = length(fieldnames(INSout))
% TODO(Julia->MATLAB): ins_out  = INSout((zeros(N) for _ = 1:N_fields)...)

% TODO(Julia->MATLAB): if !iszero(ins.P)
        ins_out.lat_std = sqrt(ins.P(1,1,:))
        ins_out.lon_std = sqrt(ins.P(2,2,:))
        ins_out.alt_std = sqrt(ins.P(3,3,:))
        ins_out.n_std   = dlat2dn(ins_out.lat_std,ins.lat)
        ins_out.e_std   = dlon2de(ins_out.lon_std,ins.lat)
    end
end
