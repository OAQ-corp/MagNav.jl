% Auto-generated from src/ekf_online_nn.jl
% Original Julia signature: function get_Hnn(g::Tuple)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_Hnn(g)
    out = [];
    Hnn = Float32[]
% TODO(Julia->MATLAB): for i in eachindex(g)
        Hnn = [Hnn;vec(g(i).weight);]
% TODO(Julia->MATLAB): !(g(i).bias isa Nothing) && (Hnn = [Hnn;vec(g(i).bias);])
    end
end
