% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_ins(ins_file::String, field::Symbol = :ins_data; dt            = 0.1, tt_sort::Bool = true, silent::Bool  = false)
% Mechanical conversion draft: review before production use.
function out = get_ins(ins_file, field, varargin)
                 dt            = 0.1,
                 tt_sort::Bool = true,
                 silent::Bool  = false)

    assert any(occursin.([".csv",".h5",".mat"],ins_file)) "$ins_file INS data file must have .csv, .h5, or .mat extension"

    silent || @info("reading in INS data: $ins_file")

    if occursin(".csv",ins_file) % get data from CSV file

        d = DataFrame(CSV.File(ins_file))

        % these fields are absolutely expected
        lat   = d[:,"ins_lat"]
        lon   = d[:,"ins_lon"]
        alt   = d[:,"ins_alt"]

        % these fields might not be included (especially dt vs tt & Cnb vs RPY)
        dt    = "ins_dt"    in names(d) ? d[:,"ins_dt"][1] : dt
        tt    = "ins_tt"    in names(d) ? d[:,"ins_tt"   ] : NaN
        vn    = "ins_vn"    in names(d) ? d[:,"ins_vn"   ] : NaN
        ve    = "ins_ve"    in names(d) ? d[:,"ins_ve"   ] : NaN
        vd    = "ins_vd"    in names(d) ? d[:,"ins_vd"   ] : NaN
        fn    = "ins_fn"    in names(d) ? d[:,"ins_fn"   ] : NaN
        fe    = "ins_fe"    in names(d) ? d[:,"ins_fe"   ] : NaN
        fd    = "ins_fd"    in names(d) ? d[:,"ins_fd"   ] : NaN
        Cnb   = NaN % matrix, not vector (column)
        roll  = "ins_roll"  in names(d) ? d[:,"ins_roll" ] : NaN
        pitch = "ins_pitch" in names(d) ? d[:,"ins_pitch"] : NaN
        yaw   = "ins_yaw"   in names(d) ? d[:,"ins_yaw"  ] : NaN
        P     = NaN % matrix, not vector (column)

    elseif occursin(".h5",ins_file) % get data from HDF5 file

        d = h5open(ins_file,"r") % read-only

        % these fields are absolutely expected
        lat   = read_check(d,:ins_lat,1,true)
        lon   = read_check(d,:ins_lon,1,true)
        alt   = read_check(d,:ins_alt,1,true)

        % these fields might not be included (especially dt vs tt & Cnb vs RPY)
        dt_   = read_check(d,:ins_dt,1,true)[1]
        dt    = isnan(dt_) ? dt : dt_
        tt    = read_check(d,:ins_tt   ,1,true)
        vn    = read_check(d,:ins_vn   ,1,true)
        ve    = read_check(d,:ins_ve   ,1,true)
        vd    = read_check(d,:ins_vd   ,1,true)
        fn    = read_check(d,:ins_fn   ,1,true)
        fe    = read_check(d,:ins_fe   ,1,true)
        fd    = read_check(d,:ins_fd   ,1,true)
        Cnb   = read_check(d,:ins_Cnb  ,1,true)
        roll  = read_check(d,:ins_roll ,1,true)
        pitch = read_check(d,:ins_pitch,1,true)
        yaw   = read_check(d,:ins_yaw  ,1,true)
        P     = read_check(d,:ins_P    ,1,true)

        close(d)

    elseif occursin(".mat",ins_file) % get data from MAT file

        d = matopen(ins_file,"r") do file
            read(file,"$field")
        end
end
