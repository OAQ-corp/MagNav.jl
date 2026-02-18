% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_XYZ20(xyz_h5::String; info::String  = splitpath(xyz_h5)[end],
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_XYZ20(xyz_h5, varargin)
    out = [];
% TODO(Julia->MATLAB): info::String  = splitpath(xyz_h5)[end],
% TODO(Julia->MATLAB): tt_sort::Bool = true,
% TODO(Julia->MATLAB): silent::Bool  = false)

    xyz_h5 = add_extension(xyz_h5,".h5")

% TODO(Julia->MATLAB): fields = :fields20

% TODO(Julia->MATLAB): silent || @info("reading in XYZ20 data: $xyz_h5")

    xyz = h5open(xyz_h5,"r") % read-only
% TODO(Julia->MATLAB): N   = maximum([length(read(xyz,k)) for k in keys(xyz)])
    d   = Dict{Symbol,Any}()
% TODO(Julia->MATLAB): ind = tt_sort ? sortperm(read_check(xyz,:tt,N,silent)) : trues(N)

% TODO(Julia->MATLAB): for field in xyz_fields(fields)
% TODO(Julia->MATLAB): field ~= :ignore && push!(d,field=>read_check(xyz,field,N,silent)[ind])
    end
end
