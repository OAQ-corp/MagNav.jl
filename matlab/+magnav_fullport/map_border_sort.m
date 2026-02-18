% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_border_sort(yy::Vector, xx::Vector, dy, dx)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = map_border_sort(yy, xx, dy, dx)
    out = [];
    d3 = 3*[dy,dx]
    ll = vcat(yy',xx')
    ll_out = zero(ll)
    ind = falses(size(ll,2))
    ind(1) = true
    ll_out(:,1) = ll(:,ind)
% TODO(Julia->MATLAB): for i in axes(ll_out,2)[2:end]
% TODO(Julia->MATLAB): ll = ll(:, .!ind)
        pt = ll_out(:,i-1)
        ll_nn = ll(:, vec(all(abs(ll .- pt) .< d3, dims=1)))
        try
% TODO(Julia->MATLAB): ind_nn = nn(KDTree(ll_nn),pt)[1]
            ind    = vec(all(ll_nn(:,ind_nn) .≈ ll, dims=1))
        catch _
            @info("full border not sorted")
% TODO(Julia->MATLAB): return (ll_out(1,1:i-1), ll_out(2,1:i-1))
        end
end
