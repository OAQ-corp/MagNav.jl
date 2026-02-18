% Auto-generated from src/analysis_util.jl
% Original Julia signature: function get_igrf(xyz::XYZ, ind = trues(xyz.traj.N);
% Mechanical conversion draft: review before production use.
function out = get_igrf(xyz, ind)
                  frame::Symbol   = :body,
                  norm_igrf::Bool = false,
                  check_xyz::Bool = true)

    date_start = get_years.(xyz.year[ind],xyz.doy[ind].-1)
    seconds_in_year = 60 * 60 * 24 * get_days_in_year.(date_start)

    assert frame in [:body,:nav] "$frame reference frame is invalid, select {:body,:nav}"
    assert all(1900 .<= date_start .<= 2030)  "start date must be in valid IGRF date range"

    N   = length(xyz.traj.lat[ind])
    tt  = date_start + xyz.traj.tt[ind] ./ seconds_in_year % [yr]
    alt = xyz.traj.alt[ind]
    lat = xyz.traj.lat[ind]
    lon = xyz.traj.lon[ind]

    % get IGRF, igrf() outputs length N vector of [Bx, By, Bz] with
    % Bx: north component [nT]
    % By: east  component [nT]
    % Bz: down  component [nT]
    igrf_vec = [igrf(tt[i], alt[i], lat[i], lon[i], Val(:geodetic)) for i = 1:N]
    if check_xyz
        lim_igrf = 1
        err_igrf = round(rms(norm.(igrf_vec) - xyz.igrf[ind]),digits=2)
        assert err_igrf < lim_igrf "IGRF discrepancy = $err_igrf > $lim_igrf nT, check `igrf`, `year`, & `doy` fields in `xyz`"
    end
end
