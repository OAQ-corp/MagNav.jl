% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_XYZ0(xyz_file::String, traj_field::Symbol = :traj, ins_field::Symbol  = :ins_data; info::String       = splitpath(xyz_file)[end],
% Mechanical conversion draft: review before production use.
function out = get_XYZ0(xyz_file, traj_field, ins_field, varargin)
                  traj_field::Symbol = :traj,
                  ins_field::Symbol  = :ins_data;
                  info::String       = splitpath(xyz_file)[end],
                  flight             = 1,
                  line               = 1,
                  year               = 2023,
                  doy                = 154,
                  dt                 = 0.1,
                  tt_sort::Bool      = true,
                  silent::Bool       = false)

    assert any(occursin.([".csv",".h5",".mat"],xyz_file)) "$xyz_file flight data file must have .csv, .h5, or .mat extension"

    traj = get_traj(xyz_file,traj_field;
                    dt      = dt,
                    tt_sort = false, % must do here
                    silent  = silent)

    insf = false % flag to create INS struct

    if occursin(".csv",xyz_file) % get data from CSV file

        d = DataFrame(CSV.File(xyz_file))

        % if needed, set flag to create INS struct = true
        any(["ins_lat","ins_lon","ins_alt"] .∉ (names(d),)) && (insf = true)

        % these fields might not be included
        info     = "info"     in names(d) ? d[:,"info"    ] : info
        flight   = "flight"   in names(d) ? d[:,"flight"  ] : flight
        line     = "line"     in names(d) ? d[:,"line"    ] : line
        year     = "year"     in names(d) ? d[:,"year"    ] : year
        doy      = "doy"      in names(d) ? d[:,"doy"     ] : doy
        diurnal  = "diurnal"  in names(d) ? d[:,"diurnal" ] : NaN
        igrf     = "igrf"     in names(d) ? d[:,"igrf"    ] : NaN
        mag_1_c  = "mag_1_c"  in names(d) ? d[:,"mag_1_c" ] : NaN
        mag_1_uc = "mag_1_uc" in names(d) ? d[:,"mag_1_uc"] : NaN

    elseif occursin(".h5",xyz_file) % get data from HDF5 file

        d = h5open(xyz_file,"r") % read-only

        % if needed, set flag to create INS struct = true
        if any(isnan.(read_check(d,:ins_lat,1,true))) |
           any(isnan.(read_check(d,:ins_lon,1,true))) |
           any(isnan.(read_check(d,:ins_alt,1,true)))
           insf = true
        end
end
