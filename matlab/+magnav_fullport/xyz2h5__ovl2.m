% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function xyz2h5(data::Array, xyz_h5::String, flight::Symbol; tt_sort::Bool      = true, lines::Vector      = [()],
% Mechanical conversion draft: review before production use.
function out = xyz2h5__ovl2(data, xyz_h5, flight, varargin)
                tt_sort::Bool      = true,
                lines::Vector      = [()],
                lines_type::Symbol = :exclude)

    fields   = xyz_fields(flight) % vector of data field names
    Nf_chk   = length(fields)     % number of data fields (columns)
    ind_tt   = findfirst(fields .== :tt)   % time index (column)
    ind_line = findfirst(fields .== :line) % line index (column)

    % number of valid data rows & data fields
    (N,Nf) = size(data)

    assert Nf == Nf_chk "xyz fields are of different dimensions, $N ≂̸ $Nf_chk"

    % check for duplicated data
    N_tt   = length(unique(data[:,ind_tt  ]))
    N_line = length(unique(data[:,ind_line]))
    N - N_tt > N_line && @info("xyz file may contain duplicated data")

    if isempty(lines[1])
        ind = trues(N)
    else

        % get ind for all lines
        ind = falses(N)
        for line in lines
            ind = ind .| get_ind(data[:,ind_tt],data[:,ind_line];
                                 lines=[line[1]],tt_lim=[line[2],line[3]])
        end
end
