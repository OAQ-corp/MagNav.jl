% Auto-generated from src/model_functions.jl
% Original Julia signature: function fogm(sigma, tau, dt, N)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = fogm(sigma, tau, dt, N)
    out = [];

    x    = zeros(N)
    x(1) = sigma*randn(Float64)
    Phi  = exp(-dt/tau)
    Q    = 2*sigma^2/tau
    Qd   = Q*dt

% TODO(Julia->MATLAB): for i = 2:N
        x(i) = Phi*x(i-1) + sqrt(Qd)*randn(Float64)
    end
end
