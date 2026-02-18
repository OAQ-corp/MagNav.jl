% Auto-generated from src/compensation.jl
% Original Julia signature: function get_curriculum_ind(TL_diff::Vector, N_sigma::Real = 1)
% Mechanical conversion draft: review before production use.
function [ind_cur, ind_nn] = get_curriculum_ind(TL_diff, N_sigma)
    TL_diff = detrend(TL_diff;mean_only=true)
    cutoff  = N_sigma*std(TL_diff)
    ind_cur = -cutoff .<= TL_diff .<= cutoff
    ind_nn  = .!ind_cur
end % function get_curriculum_ind
end
