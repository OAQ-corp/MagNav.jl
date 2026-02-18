% Auto-generated from src/analysis_util.jl
% Original Julia signature: function bpf_data(x::AbstractMatrix; bpf=get_bpf())
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = bpf_data(x, varargin)
    out = [];
    x_f = float(x)
% TODO(Julia->MATLAB): for i in axes(x,2)
        (std(x(:,i)) <= eps(eltype(x))) || (x_f(:,i) = filtfilt(bpf,x(:,i)))
    end
end
