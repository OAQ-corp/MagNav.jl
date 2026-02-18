% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_XYZ1(xyz_file::String, traj_field::Symbol = :traj, ins_field::Symbol  = :ins_data; info::String       = splitpath(xyz_file)[end],
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = get_XYZ1(xyz_file, traj_field, ins_field, varargin)
    out = [];
% TODO(Julia->MATLAB): traj_field::Symbol = :traj,
% TODO(Julia->MATLAB): ins_field::Symbol  = :ins_data;
% TODO(Julia->MATLAB): info::String       = splitpath(xyz_file)[end],
                  flight             = 1,
                  line               = 1,
                  year               = 2023,
                  doy                = 154,
                  dt                 = 0.1,
% TODO(Julia->MATLAB): tt_sort::Bool      = true,
% TODO(Julia->MATLAB): silent::Bool       = false)

% TODO(Julia->MATLAB): assert any(occursin([".csv",".h5",".mat"],xyz_file)) "$xyz_file flight data file must have .csv, .h5, or .mat extension"

    xyz = get_XYZ0(xyz_file,traj_field,ins_field;
                   info    = info,
                   flight  = flight,
                   line    = line,
                   year    = year,
                   doy     = doy,
                   dt      = dt,
% TODO(Julia->MATLAB): tt_sort = false, % must do here
                   silent  = silent)

% TODO(Julia->MATLAB): % these fields can be extracted using XYZ0 functionality
    info     = xyz.info
    traj     = xyz.traj
    ins      = xyz.ins
    flux_a   = xyz.flux_a
    flight   = xyz.flight
    line     = xyz.line
    year     = xyz.year
    doy      = xyz.doy
    diurnal  = xyz.diurnal
    igrf     = xyz.igrf
    mag_1_c  = xyz.mag_1_c
    mag_1_uc = xyz.mag_1_uc

% TODO(Julia->MATLAB): flux_b = get_flux(xyz_file,:flux_b,traj_field)

    if occursin(".csv",xyz_file) % get data from CSV file

        d = DataFrame(CSV.File(xyz_file))

        % these fields might not be included
% TODO(Julia->MATLAB): mag_2_c  = "mag_2_c"  in names(d) ? d(:,"mag_2_c" ) : NaN
% TODO(Julia->MATLAB): mag_3_c  = "mag_3_c"  in names(d) ? d(:,"mag_3_c" ) : NaN
% TODO(Julia->MATLAB): mag_2_uc = "mag_2_uc" in names(d) ? d(:,"mag_2_uc") : NaN
% TODO(Julia->MATLAB): mag_3_uc = "mag_3_uc" in names(d) ? d(:,"mag_3_uc") : NaN
% TODO(Julia->MATLAB): aux_1    = "aux_1"    in names(d) ? d(:,"aux_1"   ) : NaN
% TODO(Julia->MATLAB): aux_2    = "aux_2"    in names(d) ? d(:,"aux_2"   ) : NaN
% TODO(Julia->MATLAB): aux_3    = "aux_3"    in names(d) ? d(:,"aux_3"   ) : NaN

    elseif occursin(".h5",xyz_file) % get data from HDF5 file

        d = h5open(xyz_file,"r") % read-only

        % these fields might not be included
% TODO(Julia->MATLAB): mag_2_c  = read_check(d,:mag_2_c ,1,true)
% TODO(Julia->MATLAB): mag_3_c  = read_check(d,:mag_3_c ,1,true)
% TODO(Julia->MATLAB): mag_2_uc = read_check(d,:mag_2_uc,1,true)
% TODO(Julia->MATLAB): mag_3_uc = read_check(d,:mag_3_uc,1,true)
% TODO(Julia->MATLAB): aux_1    = read_check(d,:aux_1   ,1,true)
% TODO(Julia->MATLAB): aux_2    = read_check(d,:aux_2   ,1,true)
% TODO(Julia->MATLAB): aux_3    = read_check(d,:aux_3   ,1,true)

        close(d)

    elseif occursin(".mat",xyz_file) % get data from MAT file

% TODO(Julia->MATLAB): d = matopen(xyz_file,"r") do file
% TODO(Julia->MATLAB): read(file,"$traj_field")
        end
end
