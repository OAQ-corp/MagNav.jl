% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function xyz2h5(data::Array, xyz_h5::String, flight::Symbol; tt_sort::Bool      = true, lines::Vector      = [()],
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = xyz2h5__ovl2(data, xyz_h5, flight, varargin)
    out = [];
% TODO(Julia->MATLAB): tt_sort::Bool      = true,
% TODO(Julia->MATLAB): lines::Vector      = [()],
% TODO(Julia->MATLAB): lines_type::Symbol = :exclude)

    fields   = xyz_fields(flight) % vector of data field names
    Nf_chk   = length(fields)     % number of data fields (columns)
% TODO(Julia->MATLAB): ind_tt   = findfirst(fields == :tt)   % time index (column)
% TODO(Julia->MATLAB): ind_line = findfirst(fields == :line) % line index (column)

    % number of valid data rows & data fields
    (N,Nf) = size(data)

% TODO(Julia->MATLAB): assert Nf == Nf_chk "xyz fields are of different dimensions, $N ≂̸ $Nf_chk"

    % check for duplicated data
    N_tt   = length(unique(data(:,ind_tt  )))
    N_line = length(unique(data(:,ind_line)))
    N - N_tt > N_line && @info("xyz file may contain duplicated data")

    if isempty(lines(1))
        ind = trues(N)
    else

        % get ind for all lines
        ind = falses(N)
% TODO(Julia->MATLAB): for line in lines
            ind = ind .| get_ind(data(:,ind_tt),data(:,ind_line);
                                 lines=[line(1)],tt_lim=[line(2),line(3)])
        end
end
