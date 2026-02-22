% Auto-generated from src/compensation.jl
% Original Julia signature: function get_curriculum_ind(TL_diff::Vector, N_sigma::Real = 1)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [ind_cur, ind_nn] = get_curriculum_ind(TL_diff, N_sigma)
    ind_cur = [];
    TL_diff = detrend(TL_diff;mean_only=true)
    cutoff  = N_sigma*std(TL_diff)
    ind_cur = -cutoff .<= TL_diff .<= cutoff
% TODO(Julia->MATLAB): ind_nn  = .!ind_cur
% return (ind_cur, ind_nn)
end % function get_curriculum_ind
end
