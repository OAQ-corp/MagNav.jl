% Auto-generated from src/analysis_util.jl
% Original Julia signature: function chunk_data(x, y, l_window::Int)
% Mechanical conversion draft: review before production use.
function [x_seqs, y_seqs] = chunk_data(x, y, l_window)

    N = size(x,1)
    x = Float32.(x')
    y = Float32.(y)
    N_window = floor(Int,N/l_window)

    N % l_window == 0 || @info("data was not trimmed for l_window = $l_window, may result in worse performance")

    x_seqs = [x[:,(j-1)*l_window .+ (1:l_window)] for j = 1:N_window]
    y_seqs = [y[  (j-1)*l_window .+ (1:l_window)] for j = 1:N_window]

end % function chunk_data
end
