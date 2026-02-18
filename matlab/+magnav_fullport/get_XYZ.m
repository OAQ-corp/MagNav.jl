% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function get_XYZ(flight::Symbol, df_flight::DataFrame; tt_sort::Bool      = true, reorient_vec::Bool = false, silent::Bool       = false)
% Mechanical conversion draft: review before production use.
function out = get_XYZ(flight, df_flight, varargin)
                 tt_sort::Bool      = true,
                 reorient_vec::Bool = false,
                 silent::Bool       = false)

    ind      = findfirst(Symbol.(df_flight.flight) .== flight)
    xyz_file = String(df_flight.xyz_file[ind])
    xyz_type = Symbol(df_flight.xyz_type[ind])

    if xyz_type == nameof(XYZ0)
        xyz = get_XYZ0( xyz_file;tt_sort=tt_sort,silent=silent)
    elseif xyz_type == nameof(XYZ1)
        xyz = get_XYZ1( xyz_file;tt_sort=tt_sort,silent=silent)
    elseif xyz_type == nameof(XYZ20)
        xyz = get_XYZ20(xyz_file;tt_sort=tt_sort,silent=silent)
    elseif xyz_type == nameof(XYZ21)
        xyz = get_XYZ21(xyz_file;tt_sort=tt_sort,silent=silent)
    else
        error("$xyz_type xyz_type not defined")
    end
end
