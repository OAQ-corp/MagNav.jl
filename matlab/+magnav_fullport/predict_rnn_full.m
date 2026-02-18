% Auto-generated from src/analysis_util.jl
% Original Julia signature: function predict_rnn_full(m, x)
% Mechanical conversion draft: review before production use.
function y_hat = predict_rnn_full(m, x)

    % apply model to sequence & convert output to vector
    y_hat = vec(m(Float32.(x')))

end % function predict_rnn_full
end
