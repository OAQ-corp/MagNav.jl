% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_traj(traj_file::String, field::Symbol = :traj; dt            = 0.1, tt_sort::Bool = true, silent::Bool  = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_traj(traj_file, field, varargin)
    out = [];
                  dt            = 0.1,
% TODO(Julia->MATLAB): tt_sort::Bool = true,
% TODO(Julia->MATLAB): silent::Bool  = false)

% TODO(Julia->MATLAB): assert any(occursin([".csv",".h5",".mat"],traj_file)) "$traj_file trajectory data file must have .csv, .h5, or .mat extension"

% TODO(Julia->MATLAB): silent || @info("reading in Traj data: $traj_file")

    if occursin(".csv",traj_file) % get data from CSV file

        d = DataFrame(CSV.File(traj_file))

        % these fields are absolutely expected
        lat   = d(:,"lat")
        lon   = d(:,"lon")
        alt   = d(:,"alt")

        % these fields might not be included (especially dt vs tt & Cnb vs RPY)
% TODO(Julia->MATLAB): dt    = "dt"    in names(d) ? d(:,"dt")[1] : dt
% TODO(Julia->MATLAB): tt    = "tt"    in names(d) ? d(:,"tt"   ) : NaN
% TODO(Julia->MATLAB): vn    = "vn"    in names(d) ? d(:,"vn"   ) : NaN
% TODO(Julia->MATLAB): ve    = "ve"    in names(d) ? d(:,"ve"   ) : NaN
% TODO(Julia->MATLAB): vd    = "vd"    in names(d) ? d(:,"vd"   ) : NaN
% TODO(Julia->MATLAB): fn    = "fn"    in names(d) ? d(:,"fn"   ) : NaN
% TODO(Julia->MATLAB): fe    = "fe"    in names(d) ? d(:,"fe"   ) : NaN
% TODO(Julia->MATLAB): fd    = "fd"    in names(d) ? d(:,"fd"   ) : NaN
        Cnb   = NaN % matrix, not vector (column)
% TODO(Julia->MATLAB): roll  = "roll"  in names(d) ? d(:,"roll" ) : NaN
% TODO(Julia->MATLAB): pitch = "pitch" in names(d) ? d(:,"pitch") : NaN
% TODO(Julia->MATLAB): yaw   = "yaw"   in names(d) ? d(:,"yaw"  ) : NaN

    elseif occursin(".h5",traj_file) % get data from HDF5 file

        d = h5open(traj_file,"r") % read-only

        % these fields are absolutely expected
% TODO(Julia->MATLAB): lat   = read_check(d,:lat,1,true)
% TODO(Julia->MATLAB): lon   = read_check(d,:lon,1,true)
% TODO(Julia->MATLAB): alt   = read_check(d,:alt,1,true)

        % these fields might not be included (especially dt vs tt & Cnb vs RPY)
% TODO(Julia->MATLAB): dt_   = read_check(d,:dt,1,true)[1]
        dt    = isnan(dt_) ? dt : dt_
% TODO(Julia->MATLAB): tt    = read_check(d,:tt   ,1,true)
% TODO(Julia->MATLAB): vn    = read_check(d,:vn   ,1,true)
% TODO(Julia->MATLAB): ve    = read_check(d,:ve   ,1,true)
% TODO(Julia->MATLAB): vd    = read_check(d,:vd   ,1,true)
% TODO(Julia->MATLAB): fn    = read_check(d,:fn   ,1,true)
% TODO(Julia->MATLAB): fe    = read_check(d,:fe   ,1,true)
% TODO(Julia->MATLAB): fd    = read_check(d,:fd   ,1,true)
% TODO(Julia->MATLAB): Cnb   = read_check(d,:Cnb  ,1,true)
% TODO(Julia->MATLAB): roll  = read_check(d,:roll ,1,true)
% TODO(Julia->MATLAB): pitch = read_check(d,:pitch,1,true)
% TODO(Julia->MATLAB): yaw   = read_check(d,:yaw  ,1,true)

        close(d)

    elseif occursin(".mat",traj_file) % get data from MAT file

% TODO(Julia->MATLAB): d = matopen(traj_file,"r") do file
% TODO(Julia->MATLAB): read(file,"$field")
        end
end
