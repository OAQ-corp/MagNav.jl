% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function xyz_fields(flight::Symbol)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = xyz_fields(flight)
    out = [];

    % get csv files containing fields from sgl_flight_data_fields artifact
% TODO(Julia->MATLAB): fields20  = sgl_fields(:fields_sgl_2020)
% TODO(Julia->MATLAB): fields21  = sgl_fields(:fields_sgl_2021)
% TODO(Julia->MATLAB): fields160 = sgl_fields(:fields_sgl_160)

    d = Dict{Symbol,Vector{Symbol}}()
% TODO(Julia->MATLAB): push!(d, :fields20  => Symbol(vec(readdlm(fields20 ,','))))
% TODO(Julia->MATLAB): push!(d, :fields21  => Symbol(vec(readdlm(fields21 ,','))))
% TODO(Julia->MATLAB): push!(d, :fields160 => Symbol(vec(readdlm(fields160,','))))

% TODO(Julia->MATLAB): if flight in keys(d)

% return (d(flight))

% TODO(Julia->MATLAB): elseif flight in [:Flt1001,:Flt1002]

        % no mag_6_uc or flux_a for these flights
% TODO(Julia->MATLAB): exc = [:mag_6_uc,:flux_a_x,:flux_a_y,:flux_a_z,:flux_a_t]
% TODO(Julia->MATLAB): ind = .!(d(:fields20) .∈ (exc,))

% TODO(Julia->MATLAB): return (d(:fields20)[ind])

% TODO(Julia->MATLAB): elseif flight in [:Flt1003,:Flt1004_1005,:Flt1004,:Flt1005,
% TODO(Julia->MATLAB): :Flt1006,:Flt1007]

        % no mag_6_uc for these flights
% TODO(Julia->MATLAB): exc = [:mag_6_uc]
% TODO(Julia->MATLAB): ind = .!(d(:fields20) .∈ (exc,))

% TODO(Julia->MATLAB): return (d(:fields20)[ind])

% TODO(Julia->MATLAB): elseif flight in [:Flt1008,:Flt1009]

% TODO(Julia->MATLAB): return (d(:fields20))

% TODO(Julia->MATLAB): elseif flight in [:Flt1001_160Hz,:Flt1002_160Hz]

        % no mag_6_uc or flux_a for these flights
% TODO(Julia->MATLAB): exc = [:mag_6_uc,:flux_a_x,:flux_a_y,:flux_a_z,:flux_a_t]
% TODO(Julia->MATLAB): ind = .!(d(:fields160) .∈ (exc,))

% TODO(Julia->MATLAB): return (d(:fields160)[ind])

% TODO(Julia->MATLAB): elseif flight in [:Flt2001_2017,
% TODO(Julia->MATLAB): :Flt2001,:Flt2002,:Flt2004,:Flt2005,:Flt2006,
% TODO(Julia->MATLAB): :Flt2007,:Flt2008,:Flt2015,:Flt2016,:Flt2017]

% TODO(Julia->MATLAB): return (d(:fields21))

    else
% TODO(Julia->MATLAB): error("$flight flight not defined")
    end
end
