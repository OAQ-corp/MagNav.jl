% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_traj(traj_file::String, field::Symbol = :traj; dt            = 0.1, tt_sort::Bool = true, silent::Bool  = false)
% Mechanical conversion draft: review before production use.
function out = get_traj(traj_file, field, varargin)
                  dt            = 0.1,
                  tt_sort::Bool = true,
                  silent::Bool  = false)

    assert any(occursin.([".csv",".h5",".mat"],traj_file)) "$traj_file trajectory data file must have .csv, .h5, or .mat extension"

    silent || @info("reading in Traj data: $traj_file")

    if occursin(".csv",traj_file) % get data from CSV file

        d = DataFrame(CSV.File(traj_file))

        % these fields are absolutely expected
        lat   = d[:,"lat"]
        lon   = d[:,"lon"]
        alt   = d[:,"alt"]

        % these fields might not be included (especially dt vs tt & Cnb vs RPY)
        dt    = "dt"    in names(d) ? d[:,"dt"][1] : dt
        tt    = "tt"    in names(d) ? d[:,"tt"   ] : NaN
        vn    = "vn"    in names(d) ? d[:,"vn"   ] : NaN
        ve    = "ve"    in names(d) ? d[:,"ve"   ] : NaN
        vd    = "vd"    in names(d) ? d[:,"vd"   ] : NaN
        fn    = "fn"    in names(d) ? d[:,"fn"   ] : NaN
        fe    = "fe"    in names(d) ? d[:,"fe"   ] : NaN
        fd    = "fd"    in names(d) ? d[:,"fd"   ] : NaN
        Cnb   = NaN % matrix, not vector (column)
        roll  = "roll"  in names(d) ? d[:,"roll" ] : NaN
        pitch = "pitch" in names(d) ? d[:,"pitch"] : NaN
        yaw   = "yaw"   in names(d) ? d[:,"yaw"  ] : NaN

    elseif occursin(".h5",traj_file) % get data from HDF5 file

        d = h5open(traj_file,"r") % read-only

        % these fields are absolutely expected
        lat   = read_check(d,:lat,1,true)
        lon   = read_check(d,:lon,1,true)
        alt   = read_check(d,:alt,1,true)

        % these fields might not be included (especially dt vs tt & Cnb vs RPY)
        dt_   = read_check(d,:dt,1,true)[1]
        dt    = isnan(dt_) ? dt : dt_
        tt    = read_check(d,:tt   ,1,true)
        vn    = read_check(d,:vn   ,1,true)
        ve    = read_check(d,:ve   ,1,true)
        vd    = read_check(d,:vd   ,1,true)
        fn    = read_check(d,:fn   ,1,true)
        fe    = read_check(d,:fe   ,1,true)
        fd    = read_check(d,:fd   ,1,true)
        Cnb   = read_check(d,:Cnb  ,1,true)
        roll  = read_check(d,:roll ,1,true)
        pitch = read_check(d,:pitch,1,true)
        yaw   = read_check(d,:yaw  ,1,true)

        close(d)

    elseif occursin(".mat",traj_file) % get data from MAT file

        d = matopen(traj_file,"r") do file
            read(file,"$field")
        end
end
