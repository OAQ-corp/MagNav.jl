#!/usr/bin/env julia

# Minimal MagNav navigation run using repository test data.
# Run from repo root:
#   julia --project=. examples/navigation_entrypoint.jl

using MagNav
using MAT
using Statistics

root = dirname(@__DIR__)
test_data = joinpath(root, "test", "test_data")

ins_data = matopen(joinpath(test_data, "test_data_ins.mat"), "r") do f
    read(f, "ins_data")
end
map_data = matopen(joinpath(test_data, "test_data_map.mat"), "r") do f
    read(f, "map_data")
end
traj_data = matopen(joinpath(test_data, "test_data_traj.mat"), "r") do f
    read(f, "traj")
end

ins_lat  = deg2rad.(vec(ins_data["lat"]))
ins_lon  = deg2rad.(vec(ins_data["lon"]))
ins_alt  = vec(ins_data["alt"])
ins_vn   = vec(ins_data["vn"])
ins_ve   = vec(ins_data["ve"])
ins_vd   = vec(ins_data["vd"])
ins_fn   = vec(ins_data["fn"])
ins_fe   = vec(ins_data["fe"])
ins_fd   = vec(ins_data["fd"])
ins_Cnb  = ins_data["Cnb"]

map_info = "Map"
map_map  = map_data["map"]
map_xx   = deg2rad.(vec(map_data["xx"]))
map_yy   = deg2rad.(vec(map_data["yy"]))
map_alt  = map_data["alt"]
map_mask = MagNav.map_params(map_map, map_xx, map_yy)[2]

tt       = vec(traj_data["tt"])
lat      = deg2rad.(vec(traj_data["lat"]))
lon      = deg2rad.(vec(traj_data["lon"]))
alt      = vec(traj_data["alt"])
vn       = vec(traj_data["vn"])
ve       = vec(traj_data["ve"])
vd       = vec(traj_data["vd"])
fn       = vec(traj_data["fn"])
fe       = vec(traj_data["fe"])
fd       = vec(traj_data["fd"])
Cnb      = traj_data["Cnb"]
mag_1_c  = vec(traj_data["mag_1_c"])
N        = length(lat)
dt       = tt[2] - tt[1]

traj = MagNav.Traj(N, dt, tt, lat, lon, alt, vn, ve, vd, fn, fe, fd, Cnb)
ins  = MagNav.INS( N, dt, tt, ins_lat, ins_lon, ins_alt, ins_vn, ins_ve, ins_vd,
                   ins_fn, ins_fe, ins_fd, ins_Cnb, zeros(3,3,N))
mapS = MagNav.MapS(map_info, map_map, map_xx, map_yy, map_alt, map_mask)
itp_mapS = map_interpolate(mapS, :linear)

(crlb_out, ins_out, filt_out) = run_filt(traj, ins, mag_1_c, itp_mapS, :ekf;
                                         run_crlb = true,
                                         extract  = true)

rmse_2d = sqrt(mean((filt_out.map_alt - ins_out.map_alt) .^ 2))
println("MagNav EKF run complete")
println("samples      = $(N)")
println("dt [s]       = $(dt)")
println("2D RMSE [m]  = $(round(rmse_2d, digits=3))")
println("CRLB samples = $(length(crlb_out.map_alt_std))")
