% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_border_sort(yy::Vector, xx::Vector, dy, dx)
% Mechanical conversion draft: review before production use.
function out = map_border_sort(yy, xx, dy, dx)
    d3 = 3*[dy,dx]
    ll = vcat(yy',xx')
    ll_out = zero.(ll)
    ind = falses(size(ll,2))
    ind[1] = true
    ll_out[:,1] = ll[:,ind]
    for i in axes(ll_out,2)[2:end]
        ll = ll[:, .!ind]
        pt = ll_out[:,i-1]
        ll_nn = ll[:, vec(all(abs.(ll .- pt) .< d3, dims=1))]
        try
            ind_nn = nn(KDTree(ll_nn),pt)[1]
            ind    = vec(all(ll_nn[:,ind_nn] .≈ ll, dims=1))
        catch _
            @info("full border not sorted")
        end
end
