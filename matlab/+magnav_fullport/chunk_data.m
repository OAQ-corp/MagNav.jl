% Auto-generated from src/analysis_util.jl
% Original Julia signature: function chunk_data(x, y, l_window::Int)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [x_seqs, y_seqs] = chunk_data(x, y, l_window)
    x_seqs = [];

    N = size(x,1)
    x = Float32(x')
    y = Float32(y)
    N_window = floor(Int,N/l_window)

% TODO(Julia->MATLAB): N % l_window == 0 || @info("data was not trimmed for l_window = $l_window, may result in worse performance")

% TODO(Julia->MATLAB): x_seqs = [x(:,(j-1)*l_window .+ (1:l_window)) for j = 1:N_window]
% TODO(Julia->MATLAB): y_seqs = [y(  (j-1)*l_window .+ (1:l_window)) for j = 1:N_window]

% return (x_seqs, y_seqs)
end % function chunk_data
end
