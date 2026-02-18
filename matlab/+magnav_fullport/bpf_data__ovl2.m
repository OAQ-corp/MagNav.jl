% Auto-generated from src/analysis_util.jl
% Original Julia signature: function bpf_data(x::AbstractVector; bpf=get_bpf())
% Mechanical conversion draft: review before production use.
function out = bpf_data__ovl2(x, varargin)
    filtfilt(bpf,x)
end % function bpf_data
end
