% Auto-generated from src/get_XYZ.jl
% Original Julia signature: function xyz_reorient_vec!(xyz::XYZ)
% Executable draft: unsupported Julia-specific lines are commented with TODO.
function out = xyz_reorient_vec_bang(xyz)
    out = [];
% TODO(Julia->MATLAB): for use_vec in field_check(xyz,MagV)
        flux = getfield(xyz,use_vec) % get vector magnetometer data
        if any(isnan,flux.t) | any(flux.t.≈0)
% TODO(Julia->MATLAB): @info("found NaNs, not reorienting $use_vec")
        else
            % get start time of flight (fiducial seconds past midnight UTC) & compute IGRF directions
            ind      = trues(length(flux.x)) % entire flight
            igrf_vec = get_igrf(xyz,ind;
% TODO(Julia->MATLAB): frame     = :body,
                                norm_igrf = true,
                                check_xyz = true)

            % compute optimal rotation matrix for this flight
            igrf_matrix = permutedims(reduce(hcat,igrf_vec))
% TODO(Julia->MATLAB): flux_matrix = permutedims(reduce(hcat,normalize([ [x,y,z] for (x,y,z) in zip(flux.x,flux.y,flux.z) ])))
            R = get_optimal_rotation_matrix(flux_matrix,igrf_matrix)

            % correct vector magnetometer data
% TODO(Julia->MATLAB): for (i,Bt) in enumerate(flux.t)
                  new_flux  = Bt*R*flux_matrix(i,:)
                  flux.x(i) = new_flux(1)
                  flux.y(i) = new_flux(2)
                  flux.z(i) = new_flux(3)
            end
end
