% Auto-generated from src/compensation.jl
% Original Julia signature: function plsr_fit(x, y, k::Int = size(x,2), no_norm = falses(size(x,2));
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = plsr_fit(x, y, k, f_2_, no_norm, f_2_)
    out = [];
% TODO(Julia->MATLAB): data_norms::Tuple = (zeros(1,1),zeros(1,1),[0.0],[0.0]),
% TODO(Julia->MATLAB): l_segs::Vector    = [length(y)],
% TODO(Julia->MATLAB): return_set::Bool  = false,
% TODO(Julia->MATLAB): silent::Bool      = false)

	Nf = size(x,2)
    Ny = size(y,2)

    if k > Nf
% TODO(Julia->MATLAB): silent || @info("reducing k from $k to $Nf")
        k = Nf
    end
end
