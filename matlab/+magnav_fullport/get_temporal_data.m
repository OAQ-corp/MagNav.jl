% Auto-generated from src/compensation.jl
% Original Julia signature: function get_temporal_data(x_norm::AbstractMatrix, l_segs::Vector, l_window::Int)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_temporal_data(x_norm, l_segs, l_window)
    out = [];

    (Nf,N) = size(x_norm) % number of features & samples (instances)
% TODO(Julia->MATLAB): assert sum(l_segs) == N "sum of lines = $(sum(l_segs)) ≠ $N"

    if length(l_segs) > 1

% TODO(Julia->MATLAB): l0  = cumsum(l_segs)[1:end-1]
% TODO(Julia->MATLAB): lim = 0.25 % ad hoc to check for sequential lines in l_segs
% TODO(Julia->MATLAB): ind = [std(x_norm(:,l)-x_norm(:,l+1)) < lim for l in l0]
        l_segs_ = deepcopy(l_segs)

% TODO(Julia->MATLAB): for i in eachindex(l_segs(1:end-1))
            if ind(i)
% TODO(Julia->MATLAB): l_segs_(i+1) += l_segs_(i)
                l_segs_(i) = 0
            end
end
