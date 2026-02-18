% Auto-generated from src/compensation.jl
% Original Julia signature: function get_temporal_data(x_norm::AbstractMatrix, l_segs::Vector, l_window::Int)
% Mechanical conversion draft: review before production use.
function out = get_temporal_data(x_norm, l_segs, l_window)

    (Nf,N) = size(x_norm) % number of features & samples (instances)
    assert sum(l_segs) == N "sum of lines = $(sum(l_segs)) ≠ $N"

    if length(l_segs) > 1

        l0  = cumsum(l_segs)[1:end-1]
        lim = 0.25 % ad hoc to check for sequential lines in l_segs
        ind = [std(x_norm[:,l]-x_norm[:,l+1]) < lim for l in l0]
        l_segs_ = deepcopy(l_segs)

        for i in eachindex(l_segs[1:end-1])
            if ind[i]
                l_segs_[i+1] += l_segs_[i]
                l_segs_[i] = 0
            end
end
