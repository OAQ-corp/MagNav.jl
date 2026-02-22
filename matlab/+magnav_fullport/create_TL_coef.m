% Auto-generated from src/tolles_lawson.jl
% Original Julia signature: function create_TL_coef(Bx, By, Bz, B; Bt         = sqrt.(Bx.^2+By.^2+Bz.^2),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = create_TL_coef(Bx, By, Bz, B, varargin)
    out = [];
                        Bt         = sqrt(Bx.^2+By.^2+Bz.^2),
                        λ          = 0,
% TODO(Julia->MATLAB): terms      = [:permanent,:induced,:eddy],
                        pass1      = 0.1,
                        pass2      = 0.9,
                        fs         = 10.0,
% TODO(Julia->MATLAB): pole::Int  = 4,
% TODO(Julia->MATLAB): trim::Int  = 20,
                        Bt_scale   = 50000,
                        return_var = false)

    % create filter
    if ((pass1 > 0) & (pass1 < fs/2)) | ((pass2 > 0) & (pass2 < fs/2))
        perform_filter = true % bandpass, low-pass, or high-pass
        bpf = get_bpf(;pass1=pass1,pass2=pass2,fs=fs,pole=pole)
    else
        perform_filter = false % all-pass
        @info("not filtering (or trimming) Tolles-Lawson data")
    end
end
