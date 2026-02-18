% Auto-generated from src/analysis_util.jl
% Original Julia signature: function bpf_data(x::AbstractMatrix; bpf=get_bpf())
% Mechanical conversion draft: review before production use.
function out = bpf_data(x, varargin)
    x_f = float.(x)
    for i in axes(x,2)
        (std(x[:,i]) <= eps(eltype(x))) || (x_f[:,i] = filtfilt(bpf,x[:,i]))
    end
end
