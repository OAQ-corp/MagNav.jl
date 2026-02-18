% Auto-generated from src/ekf_online_nn.jl
% Original Julia signature: function get_Hnn(g::Tuple)
% Mechanical conversion draft: review before production use.
function out = get_Hnn(g)
    Hnn = Float32[]
    for i in eachindex(g)
        Hnn = [Hnn;vec(g[i].weight);]
        !(g[i].bias isa Nothing) && (Hnn = [Hnn;vec(g[i].bias);])
    end
end
