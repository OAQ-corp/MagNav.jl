% Auto-generated from src/xyz2h5.jl
% Original Julia signature: function xyz_fields(flight::Symbol)
% Mechanical conversion draft: review before production use.
function out = xyz_fields(flight)

    % get csv files containing fields from sgl_flight_data_fields artifact
    fields20  = sgl_fields(:fields_sgl_2020)
    fields21  = sgl_fields(:fields_sgl_2021)
    fields160 = sgl_fields(:fields_sgl_160)

    d = Dict{Symbol,Vector{Symbol}}()
    push!(d, :fields20  => Symbol.(vec(readdlm(fields20 ,','))))
    push!(d, :fields21  => Symbol.(vec(readdlm(fields21 ,','))))
    push!(d, :fields160 => Symbol.(vec(readdlm(fields160,','))))

    if flight in keys(d)


    elseif flight in [:Flt1001,:Flt1002]

        % no mag_6_uc or flux_a for these flights
        exc = [:mag_6_uc,:flux_a_x,:flux_a_y,:flux_a_z,:flux_a_t]
        ind = .!(d[:fields20] .∈ (exc,))


    elseif flight in [:Flt1003,:Flt1004_1005,:Flt1004,:Flt1005,
                      :Flt1006,:Flt1007]

        % no mag_6_uc for these flights
        exc = [:mag_6_uc]
        ind = .!(d[:fields20] .∈ (exc,))


    elseif flight in [:Flt1008,:Flt1009]


    elseif flight in [:Flt1001_160Hz,:Flt1002_160Hz]

        % no mag_6_uc or flux_a for these flights
        exc = [:mag_6_uc,:flux_a_x,:flux_a_y,:flux_a_z,:flux_a_t]
        ind = .!(d[:fields160] .∈ (exc,))


    elseif flight in [:Flt2001_2017,
                      :Flt2001,:Flt2002,:Flt2004,:Flt2005,:Flt2006,
                      :Flt2007,:Flt2008,:Flt2015,:Flt2016,:Flt2017]


    else
        error("$flight flight not defined")
    end
end
