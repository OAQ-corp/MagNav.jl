% Auto-generated from src/analysis_util.jl
% Original Julia signature: function predict_rnn_windowed(m, x, l_window::Int)
% Mechanical conversion draft: review before production use.
function out = predict_rnn_windowed(m, x, l_window)

    N     = size(x,1)
    x     = Float32.(x')
    y_hat = zeros(eltype(x),N)

    % assume l_window = 4
    % 1 2 3 4 5 6 7 8
    %     i     j

    for j = 1:N
        i = j < l_window ? 1 : j - l_window + 1 % create window
        y_hat[j] = m(x[:,i:j])[end][1] % store last value in sequence window
    end
end
