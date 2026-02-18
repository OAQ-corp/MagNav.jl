% Auto-generated from src/create_XYZ.jl
% Original Julia signature: function create_flux(lat, lon, mapV::MapV = get_map(emm720);
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = create_flux(lat, lon, mapV)
    out = [];
                     Cnb          = repeat(I(3),1,1,length(lat)),
                     alt          = 1000,
                     dt           = 0.1,
                     meas_var     = 1.0^2,
                     fogm_sigma   = 1.0,
                     fogm_tau     = 600.0,
% TODO(Julia->MATLAB): silent::Bool = false)

    N = length(lat)

    % map values along trajectory
    silent || @info("getting vector map values, possibly with upward/downward continuation")
    (Bx,By,Bz) = get_map_val(mapV,lat,lon,alt;α=200)

    % FOGM & white noise
    silent || @info("adding FOGM & white noise to vector map values")
% TODO(Julia->MATLAB): Bx += fogm(fogm_sigma,fogm_tau,dt,N) + sqrt(meas_var)*randn(N)
% TODO(Julia->MATLAB): By += fogm(fogm_sigma,fogm_tau,dt,N) + sqrt(meas_var)*randn(N)
% TODO(Julia->MATLAB): Bz += fogm(fogm_sigma,fogm_tau,dt,N) + sqrt(meas_var)*randn(N)
    Bt  = sqrt(Bx.^2+By.^2+Bz.^2)

    % put measurements into body frame
% TODO(Julia->MATLAB): for i = 1:N
        (Bx(i),By(i),Bz(i)) = Cnb(:,:,i)' * [Bx(i),By(i),Bz(i)]
    end
end
