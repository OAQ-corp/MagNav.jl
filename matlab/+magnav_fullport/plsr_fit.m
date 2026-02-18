% Auto-generated from src/compensation.jl
% Original Julia signature: function plsr_fit(x, y, k::Int = size(x,2), no_norm = falses(size(x,2));
% Mechanical conversion draft: review before production use.
function out = plsr_fit(x, y, k, f_2_, no_norm, f_2_)
                  data_norms::Tuple = (zeros(1,1),zeros(1,1),[0.0],[0.0]),
                  l_segs::Vector    = [length(y)],
                  return_set::Bool  = false,
                  silent::Bool      = false)

	Nf = size(x,2)
    Ny = size(y,2)

    if k > Nf
        silent || @info("reducing k from $k to $Nf")
        k = Nf
    end
end
