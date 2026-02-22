% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function zero_ins_ll(ins_lat::Vector, ins_lon::Vector, err::Real = 0.0, lat::Vector = ins_lat[1:1], lon::Vector = ins_lon[1:1])
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = zero_ins_ll(ins_lat, ins_lon, err, lat, lon)
    out = [];
% TODO(Julia->MATLAB): lat::Vector = ins_lat(1:1), lon::Vector = ins_lon(1:1))

    % check that INS vectors are the same length and get length
    N_lat = length(ins_lat)
    N_lon = length(ins_lon)
    N_lat == N_lon ? (N = N_lat) : error("N_ins_lat ≂̸ N_ins_lon")

    % check that truth vectors (or scalar) are the same length and get length
    N_zero_lat = length(lat)
    N_zero_lon = length(lon)
    N_zero_lat == N_zero_lon ? (N_zero = N_zero_lat) : error("N_lat ≂̸ N_lon")

% TODO(Julia->MATLAB): % avoid modifying original data (possibly in xyz struct)
    ins_lat = float(ins_lat)
    ins_lon = float(ins_lon)

% TODO(Julia->MATLAB): % correct 1:N_zero
% TODO(Julia->MATLAB): δlat = ins_lat(1:N_zero) - lat
% TODO(Julia->MATLAB): δlon = ins_lon(1:N_zero) - lon
% TODO(Julia->MATLAB): ins_lat(1:N_zero) .-= (δlat .- sign(δlat) .* dn2dlat(err,lat))
% TODO(Julia->MATLAB): ins_lon(1:N_zero) .-= (δlon .- sign(δlon) .* de2dlon(err,lat))

% TODO(Julia->MATLAB): % correct N_zero+1:end
    if N > N_zero
        δlat_end = δlat(end) .- sign(δlat(end)) .* dn2dlat(err,lat(end))
        δlon_end = δlon(end) .- sign(δlon(end)) .* de2dlon(err,lat(end))
% TODO(Julia->MATLAB): ins_lat(N_zero+1:end) .-= δlat_end
% TODO(Julia->MATLAB): ins_lon(N_zero+1:end) .-= δlon_end
    end
end
