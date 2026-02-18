% Auto-generated from src/map_functions.jl
% Original Julia signature: function map_get_gxf(map_gxf::String)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function [map_map, map_xx, map_yy] = map_get_gxf(map_gxf)
    map_map = [];

    map_gxf = add_extension(map_gxf,".gxf")

    % configure dataset to be read as Float64
    ArchGDAL.setconfigoption("GXF_DATATYPE","Float64")

    % read GXF (raster-type) dataset from map_gxf
% TODO(Julia->MATLAB): ArchGDAL.read(map_gxf) do dataset

        % read map data into array
% TODO(Julia->MATLAB): % rows reversed to match getgrd2 in MATLAB
        map_map = reverse(ArchGDAL.read(dataset,1)',dims=1)

        % read size of map
        nx = ArchGDAL.width(dataset)
        ny = ArchGDAL.height(dataset)

        % read geometry transformation properties
        gt = ArchGDAL.getgeotransform(dataset)

        % create x & y coordinate arrays
% TODO(Julia->MATLAB): % map_yy reversed to match getgrd2 in MATLAB
% TODO(Julia->MATLAB): % both offset by half step size to match getgrd2 in MATLAB
        map_xx = [LinRange(gt(1),gt(1)+gt(2)*(nx-1),nx);] .+ gt(2)/2
        map_yy = [LinRange(gt(4)+gt(6)*(ny-1),gt(4),ny);] .+ gt(6)/2

        % dummy value used where no data exists
        dum = minimum(map_map)
% TODO(Julia->MATLAB): replace!(map_map, dum=>0)
% TODO(Julia->MATLAB): replace!(map_map, NaN=>0) % just in case

% TODO(Julia->MATLAB): % map_map differs from  getgrd2 in MATLAB by ~1e-7
% return (map_map, map_xx, map_yy)

    end
end
