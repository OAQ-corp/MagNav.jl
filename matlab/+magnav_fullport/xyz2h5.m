% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function xyz2h5(xyz_xyz::String, xyz_h5::String, flight::Symbol; lines::Vector        = [()],
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = xyz2h5(xyz_xyz, xyz_h5, flight, varargin)
    out = [];
% TODO(Julia->MATLAB): lines::Vector        = [()],
% TODO(Julia->MATLAB): lines_type::Symbol   = :exclude,
% TODO(Julia->MATLAB): tt_sort::Bool        = true,
% TODO(Julia->MATLAB): downsample_160::Bool = true,
% TODO(Julia->MATLAB): return_data::Bool    = false)

    xyz_xyz = add_extension(xyz_xyz,".xyz")
    xyz_h5  = add_extension(xyz_h5 ,".h5")

    fields   = xyz_fields(flight) % vector of data field names
    Nf       = length(fields)     % number of data fields (columns)
% TODO(Julia->MATLAB): ind_tt   = findfirst(fields == :tt)   % time index (column)
% TODO(Julia->MATLAB): ind_line = findfirst(fields == :line) % line index (column)

    % find valid data rows (correct number of columns)
% TODO(Julia->MATLAB): ind = [(length(split(line)) == Nf) for line in eachline(xyz_xyz)]

    % if 160 Hz data, find valid 10 Hz data rows (tt is multiple of 0.1)
% TODO(Julia->MATLAB): % probably better ways to do this, but it works ok
% TODO(Julia->MATLAB): if downsample_160 & (flight in [:Flt1001_160Hz,:Flt1002_160Hz])
% TODO(Julia->MATLAB): for (i,line) in enumerate(eachline(xyz_xyz))
% TODO(Julia->MATLAB): ind(i) && (ind(i) = (par(split(line)[ind_tt])+1e-6) % 0.1 < 1e-3)
        end
end
