% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function create_mag_c(lat, lon, mapS::Union{MapS,MapSd,MapS3D} = get_map(namad);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = create_mag_c(lat, lon, mapS, MapSd, MapS3D_)
    out = [];
                      alt          = 1000,
                      dt           = 0.1,
                      meas_var     = 1.0^2,
                      fogm_sigma   = 1.0,
                      fogm_tau     = 600.0,
% TODO(Julia->MATLAB): silent::Bool = false)

    % convert MapS3D to MapS at alt
    mapS isa MapS3D && (mapS = upward_fft(mapS,alt))

    N = length(lat)
    (ind0,ind1,_,_) = map_params(mapS)

    % fill map if >1% unfilled
    if sum(ind0)/sum(ind0+ind1) > 0.01
% TODO(Julia->MATLAB): silent || @info("filling in scalar map")
        mapS = map_fill(map_trim(mapS))
    end
end
