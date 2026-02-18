% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_flux(flux_file::String, use_vec::Symbol = :flux_a, field::Symbol   = :traj)
% Mechanical conversion draft: review before production use.
function out = get_flux(flux_file, use_vec, field)
                  use_vec::Symbol = :flux_a,
                  field::Symbol   = :traj)

    assert any(occursin.([".csv",".h5",".mat"],flux_file)) "$flux_file vector magnetometer data file must have .csv, .h5, or .mat extension"

    if occursin(".csv",flux_file) % get data from CSV file

        d = DataFrame(CSV.File(flux_file))
        x = "$(use_vec)_x" in names(d) ? d[:,"$(use_vec)_x"] : NaN
        y = "$(use_vec)_y" in names(d) ? d[:,"$(use_vec)_y"] : NaN
        z = "$(use_vec)_z" in names(d) ? d[:,"$(use_vec)_z"] : NaN
        t = "$(use_vec)_t" in names(d) ? d[:,"$(use_vec)_t"] : NaN

    elseif occursin(".h5",flux_file) % get data from HDF5 file

        d = h5open(flux_file,"r") % read-only

        x = read_check(d,Symbol(use_vec,"_x"),1,true)
        y = read_check(d,Symbol(use_vec,"_y"),1,true)
        z = read_check(d,Symbol(use_vec,"_z"),1,true)
        t = read_check(d,Symbol(use_vec,"_t"),1,true)

        close(d)

    elseif occursin(".mat",flux_file) % get data from MAT file

        d = matopen(flux_file,"r") do file
            read(file,"$field")
        end
end
