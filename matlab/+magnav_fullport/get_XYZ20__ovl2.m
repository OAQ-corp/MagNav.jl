% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_XYZ20(xyz_160_h5::String, xyz_h5::String; info::String = splitpath(xyz_160_h5)[end] * " & " * splitpath(xyz_h5)[end],
% Mechanical conversion draft: review before production use.
function out = get_XYZ20__ovl2(xyz_160_h5, xyz_h5, varargin)
                   info::String = splitpath(xyz_160_h5)[end] * " & " * splitpath(xyz_h5)[end],
                   silent::Bool = false)

    xyz_160_h5 = add_extension(xyz_160_h5,".h5")
    xyz_h5     = add_extension(xyz_h5    ,".h5")

    fields = :fields160

    silent || @info("reading in XYZ20 data: $xyz_160_h5")

    xyz = h5open(xyz_160_h5,"r") % read-only
    N   = maximum([length(read(xyz,k)) for k in keys(xyz)])
    d   = Dict{Symbol,Any}()
    ind = sortperm(read_check(xyz,:tt,N,silent))

    for field in xyz_fields(fields)
        field ~= :ignore && push!(d,field=>read_check(xyz,field,N,silent)[ind])
    end
end
