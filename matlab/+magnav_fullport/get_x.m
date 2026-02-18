% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_x(xyz::XYZ, ind = trues(xyz.traj.N),
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_x(xyz, ind)
    out = [];
% TODO(Julia->MATLAB): features_setup::Vector{Symbol}   = [:mag_1_uc,:TL_A_flux_a];
% TODO(Julia->MATLAB): features_no_norm::Vector{Symbol} = Symbol[],
% TODO(Julia->MATLAB): terms             = [:permanent,:induced,:eddy],
% TODO(Julia->MATLAB): sub_diurnal::Bool = false,
% TODO(Julia->MATLAB): sub_igrf::Bool    = false,
% TODO(Julia->MATLAB): bpf_mag::Bool     = false)

    line     = xyz.line(ind)
    N        = length(line)
    d        = Dict{Symbol,Array{eltype(line)}}()
    x        = Matrix{eltype(line)}(undef,N,0)
    no_norm  = Vector{Bool}(undef,0)
    features = Vector{Symbol}(undef,0)

    assert N > 2 "ind must contain at least 3 data points"

% TODO(Julia->MATLAB): for use_vec in field_check(xyz,MagV)
        A = create_TL_A(getfield(xyz,use_vec),ind;terms=terms)
% TODO(Julia->MATLAB): push!(d,Symbol("TL_A_",use_vec)=>A)
    end
end
