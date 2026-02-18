% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_ind(tt::Vector, line::Vector; ind    = trues(length(tt)),
% Mechanical conversion draft: review before production use.
function out = get_ind(tt, line, varargin)
                 ind    = trues(length(tt)),
                 lines  = (),
                 tt_lim = (),
                 splits = (1))

    assert sum(splits) ≈ 1 "sum of splits = $(sum(splits)) ≠ 1"
    assert length(tt_lim) <= 2 "length of tt_lim = $(length(tt_lim)) > 2"
    assert length(splits) <= 3 "number of splits = $(length(splits)) > 3"

    if ind isa AbstractVector{Bool}
        ind_ = deepcopy(ind)
    else
        ind_ = eachindex(tt) .∈ (ind,)
    end
end
