% Auto-generated from src/compensation.jl
% Original Julia signature: function get_split(N::Int, frac_train::Real, window_type::Symbol = :none; l_window::Int = 0)
% Mechanical conversion draft: review before production use.
function out = get_split(N, frac_train, window_type, varargin)
                   l_window::Int = 0)

    assert 0 <= frac_train <= 1 "frac_train of $frac_train is not between 0 & 1"
    assert l_window < N "window length of $l_window is too large for $N samples"

    if window_type == :none % no windows
        if frac_train < 1
            p       = randperm(N)
            N_train = floor(Int,N*frac_train)
            p_train = p[1:N_train]
            p_val   = p[N_train+1:end]
        else
            p       = 1:N
            p_train = p
            p_val   = p
        end
end
