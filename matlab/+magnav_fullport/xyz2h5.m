% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function xyz2h5(xyz_xyz::String, xyz_h5::String, flight::Symbol; lines::Vector        = [()],
% Mechanical conversion draft: review before production use.
function out = xyz2h5(xyz_xyz, xyz_h5, flight, varargin)
                lines::Vector        = [()],
                lines_type::Symbol   = :exclude,
                tt_sort::Bool        = true,
                downsample_160::Bool = true,
                return_data::Bool    = false)

    xyz_xyz = add_extension(xyz_xyz,".xyz")
    xyz_h5  = add_extension(xyz_h5 ,".h5")

    fields   = xyz_fields(flight) % vector of data field names
    Nf       = length(fields)     % number of data fields (columns)
    ind_tt   = findfirst(fields .== :tt)   % time index (column)
    ind_line = findfirst(fields .== :line) % line index (column)

    % find valid data rows (correct number of columns)
    ind = [(length(split(line)) == Nf) for line in eachline(xyz_xyz)]

    % if 160 Hz data, find valid 10 Hz data rows (tt is multiple of 0.1)
    % probably better ways to do this, but it works ok
    if downsample_160 & (flight in [:Flt1001_160Hz,:Flt1002_160Hz])
        for (i,line) in enumerate(eachline(xyz_xyz))
            ind[i] && (ind[i] = (par(split(line)[ind_tt])+1e-6) % 0.1 < 1e-3)
        end
end
