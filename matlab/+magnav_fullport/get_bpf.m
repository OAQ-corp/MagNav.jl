% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_bpf(; pass1 = 0.1, pass2 = 0.9, fs = 10.0, pole::Int = 4)
% Mechanical conversion draft: review before production use.
function out = get_bpf(varargin)
    if     ((pass1 >  0) & (pass1 <  fs/2)) & ((pass2 >  0) & (pass2 <  fs/2))
        p = Bandpass(pass1,pass2) % bandpass
    elseif ((pass1 <= 0) | (pass1 >= fs/2)) & ((pass2 >  0) & (pass2 <  fs/2))
        p = Lowpass(pass2)        % low-pass
    elseif ((pass1 >  0) & (pass1 <  fs/2)) & ((pass2 <= 0) | (pass2 >= fs/2))
        p = Highpass(pass1)       % high-pass
    else
        error("$pass1 & $pass2 passband frequencies are invalid")
    end
end
