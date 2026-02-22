% Auto-generated from src/analysis_util.jl
% Original Julia signature: function predict_rnn_full(m, x)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function y_hat = predict_rnn_full(m, x)
    y_hat = [];

    % apply model to sequence & convert output to vector
    y_hat = vec(m(Float32(x')))

% return (y_hat)
end % function predict_rnn_full
end
