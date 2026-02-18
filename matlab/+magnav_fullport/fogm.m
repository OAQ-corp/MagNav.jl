% Auto-generated from src/model_functions.jl
% Original Julia signature: function fogm(sigma, tau, dt, N)
% Mechanical conversion draft: review before production use.
function out = fogm(sigma, tau, dt, N)

    x    = zeros(N)
    x[1] = sigma*randn(Float64)
    Phi  = exp(-dt/tau)
    Q    = 2*sigma^2/tau
    Qd   = Q*dt

    for i = 2:N
        x[i] = Phi*x[i-1] + sqrt(Qd)*randn(Float64)
    end
end
