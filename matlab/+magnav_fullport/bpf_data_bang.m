% Auto-generated from src/analysis_util.jl
% Original Julia signature: function bpf_data!(x::AbstractVecOrMat; bpf=get_bpf())
% Mechanical conversion draft: review before production use.
function nothing = bpf_data_bang(x, varargin)
    x .= bpf_data(x;bpf=bpf)
end % function bpf_data!
end
