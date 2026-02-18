% Auto-generated from src/eval_filt.jl
% Original Julia signature: function eval_results(traj::Traj, ins::INS, filt_res::FILTres, crlb_P::Array)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function crlb_P = eval_results(traj, ins, filt_res, crlb_P)
    crlb_P = [];
% return (eval_crlb(traj,crlb_P),
            eval_ins( traj,ins),
            eval_filt(traj,ins,filt_res))
end % function eval_results
end
