% Auto-generated from src/analysis_util.jl
% Original Julia signature: function bpf_data(x::AbstractVector; bpf=get_bpf())
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = bpf_data__ovl2(x, varargin)
    out = [];
    filtfilt(bpf,x)
end % function bpf_data
end
