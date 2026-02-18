% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_ins(ins_file::String, field::Symbol = :ins_data; dt            = 0.1, tt_sort::Bool = true, silent::Bool  = false)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_ins(ins_file, field, varargin)
    out = [];
                 dt            = 0.1,
% TODO(Julia->MATLAB): tt_sort::Bool = true,
% TODO(Julia->MATLAB): silent::Bool  = false)

% TODO(Julia->MATLAB): assert any(occursin([".csv",".h5",".mat"],ins_file)) "$ins_file INS data file must have .csv, .h5, or .mat extension"

% TODO(Julia->MATLAB): silent || @info("reading in INS data: $ins_file")

    if occursin(".csv",ins_file) % get data from CSV file

        d = DataFrame(CSV.File(ins_file))

        % these fields are absolutely expected
        lat   = d(:,"ins_lat")
        lon   = d(:,"ins_lon")
        alt   = d(:,"ins_alt")

        % these fields might not be included (especially dt vs tt & Cnb vs RPY)
% TODO(Julia->MATLAB): dt    = "ins_dt"    in names(d) ? d(:,"ins_dt")[1] : dt
% TODO(Julia->MATLAB): tt    = "ins_tt"    in names(d) ? d(:,"ins_tt"   ) : NaN
% TODO(Julia->MATLAB): vn    = "ins_vn"    in names(d) ? d(:,"ins_vn"   ) : NaN
% TODO(Julia->MATLAB): ve    = "ins_ve"    in names(d) ? d(:,"ins_ve"   ) : NaN
% TODO(Julia->MATLAB): vd    = "ins_vd"    in names(d) ? d(:,"ins_vd"   ) : NaN
% TODO(Julia->MATLAB): fn    = "ins_fn"    in names(d) ? d(:,"ins_fn"   ) : NaN
% TODO(Julia->MATLAB): fe    = "ins_fe"    in names(d) ? d(:,"ins_fe"   ) : NaN
% TODO(Julia->MATLAB): fd    = "ins_fd"    in names(d) ? d(:,"ins_fd"   ) : NaN
        Cnb   = NaN % matrix, not vector (column)
% TODO(Julia->MATLAB): roll  = "ins_roll"  in names(d) ? d(:,"ins_roll" ) : NaN
% TODO(Julia->MATLAB): pitch = "ins_pitch" in names(d) ? d(:,"ins_pitch") : NaN
% TODO(Julia->MATLAB): yaw   = "ins_yaw"   in names(d) ? d(:,"ins_yaw"  ) : NaN
        P     = NaN % matrix, not vector (column)

    elseif occursin(".h5",ins_file) % get data from HDF5 file

        d = h5open(ins_file,"r") % read-only

        % these fields are absolutely expected
% TODO(Julia->MATLAB): lat   = read_check(d,:ins_lat,1,true)
% TODO(Julia->MATLAB): lon   = read_check(d,:ins_lon,1,true)
% TODO(Julia->MATLAB): alt   = read_check(d,:ins_alt,1,true)

        % these fields might not be included (especially dt vs tt & Cnb vs RPY)
% TODO(Julia->MATLAB): dt_   = read_check(d,:ins_dt,1,true)[1]
        dt    = isnan(dt_) ? dt : dt_
% TODO(Julia->MATLAB): tt    = read_check(d,:ins_tt   ,1,true)
% TODO(Julia->MATLAB): vn    = read_check(d,:ins_vn   ,1,true)
% TODO(Julia->MATLAB): ve    = read_check(d,:ins_ve   ,1,true)
% TODO(Julia->MATLAB): vd    = read_check(d,:ins_vd   ,1,true)
% TODO(Julia->MATLAB): fn    = read_check(d,:ins_fn   ,1,true)
% TODO(Julia->MATLAB): fe    = read_check(d,:ins_fe   ,1,true)
% TODO(Julia->MATLAB): fd    = read_check(d,:ins_fd   ,1,true)
% TODO(Julia->MATLAB): Cnb   = read_check(d,:ins_Cnb  ,1,true)
% TODO(Julia->MATLAB): roll  = read_check(d,:ins_roll ,1,true)
% TODO(Julia->MATLAB): pitch = read_check(d,:ins_pitch,1,true)
% TODO(Julia->MATLAB): yaw   = read_check(d,:ins_yaw  ,1,true)
% TODO(Julia->MATLAB): P     = read_check(d,:ins_P    ,1,true)

        close(d)

    elseif occursin(".mat",ins_file) % get data from MAT file

% TODO(Julia->MATLAB): d = matopen(ins_file,"r") do file
% TODO(Julia->MATLAB): read(file,"$field")
        end
end
