% Auto-generated from src/get_map.jl
% Original Julia signature: function get_map(map_file::String   = namad, map_field::Symbol  = :map_data; map_info::String   = splitpath(map_file)[end],
% Mechanical conversion draft: review before production use.
function out = get_map(map_file, map_field, varargin)
                 map_field::Symbol  = :map_data;
                 map_info::String   = splitpath(map_file)[end],
                 map_units::Symbol  = :rad,
                 file_units::Symbol = :deg,
                 flip_map::Bool     = false)

    assert any(occursin.([".h5",".mat"],map_file)) | isdir(map_file) "$map_file map data file must have .h5 or .mat extension or be a folder containing .csv files"

    map_vec = false

    if occursin(".h5",map_file) % get data from HDF5 file

            map_data = h5open(map_file,"r") % read-only

            if haskey(map_data,"mapX") % vector map
                map_vec  = true
                map_mapX = read_check(map_data,:mapX)
                map_mapY = read_check(map_data,:mapY)
                map_mapZ = read_check(map_data,:mapZ)
                map_mask = map_params(map_mapX)[2]
            elseif haskey(map_data,"map") % scalar map
                map_map  = read_check(map_data,:map)
                map_mask = map_params(map_map)[2]
            end
end
