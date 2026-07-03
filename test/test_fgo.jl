using MagNav, Test, MAT
using LinearAlgebra
using MagNav: FILTres

test_file = joinpath(@__DIR__,"test_data","test_data_ekf.mat")
ekf_data  = matopen(test_file,"r") do file
    read(file,"ekf_data")
end

test_file = joinpath(@__DIR__,"test_data","test_data_ins.mat")
ins_data  = matopen(test_file,"r") do file
    read(file,"ins_data")
end

test_file = joinpath(@__DIR__,"test_data","test_data_map.mat")
map_data  = matopen(test_file,"r") do file
    read(file,"map_data")
end

test_file = joinpath(@__DIR__,"test_data","test_data_params.mat")
params    = matopen(test_file,"r") do file
    read(file,"params")
end

test_file = joinpath(@__DIR__,"test_data","test_data_traj.mat")
traj_data = matopen(test_file,"r") do file
    read(file,"traj")
end

P0 = ekf_data["P0"]
Qd = ekf_data["Qd"]
R  = ekf_data["R"]

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
map_mask = MagNav.map_params(map_map,map_xx,map_yy)[2]

dt       = params["dt"]
baro_tau = params["baro_tau"]
acc_tau  = params["acc_tau"]
gyro_tau = params["gyro_tau"]
fogm_tau = params["meas_tau"]

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

traj = MagNav.Traj(N,dt,tt,lat,lon,alt,vn,ve,vd,fn,fe,fd,Cnb)
ins  = MagNav.INS( N,dt,tt,ins_lat,ins_lon,ins_alt,ins_vn,ins_ve,ins_vd,
                   ins_fn,ins_fe,ins_fd,ins_Cnb,zeros(3,3,N))

mapS = MagNav.MapS(map_info,map_map,map_xx,map_yy,map_alt,map_mask)
map_cache = Map_Cache(maps=[mapS])
(itp_mapS,der_mapS) = map_interpolate(mapS,:linear;return_vert_deriv=true) # linear to match MATLAB

# factor graph optimization (batch MAP smoother)
fgo_res = fgo(ins_lat,ins_lon,ins_alt,ins_vn,ins_ve,ins_vd,
              ins_fn,ins_fe,ins_fd,ins_Cnb,mag_1_c,dt,itp_mapS;
              P0       = P0,
              Qd       = Qd,
              R        = R,
              baro_tau = baro_tau,
              acc_tau  = acc_tau,
              gyro_tau = gyro_tau,
              fogm_tau = fogm_tau,
              core     = false)

# EKF for comparison (same model)
ekf_res = ekf(ins_lat,ins_lon,ins_alt,ins_vn,ins_ve,ins_vd,
              ins_fn,ins_fe,ins_fd,ins_Cnb,mag_1_c,dt,itp_mapS;
              P0       = P0,
              Qd       = Qd,
              R        = R,
              baro_tau = baro_tau,
              acc_tau  = acc_tau,
              gyro_tau = gyro_tau,
              fogm_tau = fogm_tau,
              core     = false)

# horizontal position DRMS [m] helper (INS position + estimated error vs truth)
drms(filt_res) = sqrt(mean(
    dlat2dn.(ins_lat .+ filt_res.x[1,:] .- lat, lat).^2 .+
    dlon2de.(ins_lon .+ filt_res.x[2,:] .- lon, lat).^2))
ins_drms = sqrt(mean(dlat2dn.(ins_lat .- lat, lat).^2 .+
                     dlon2de.(ins_lon .- lon, lat).^2))

@testset "fgo output structure" begin
    @test fgo_res isa FILTres
    @test size(fgo_res.x) == size(ekf_res.x)
    @test size(fgo_res.P) == size(ekf_res.P)
    @test size(fgo_res.r) == size(ekf_res.r)
    @test all(isfinite, fgo_res.x)
    @test all(isfinite, fgo_res.P)
    @test all(isfinite, fgo_res.r)
    @test all(diag(fgo_res.P[:,:,1])   .>= 0) # covariance diagonals non-negative
    @test all(diag(fgo_res.P[:,:,end]) .>= 0)
    @test fgo_res.P[:,:,1]   ≈ fgo_res.P[:,:,1]'   atol=1e-8 # symmetric
    @test fgo_res.P[:,:,end] ≈ fgo_res.P[:,:,end]' atol=1e-8
end

@testset "fgo navigation accuracy" begin
    # smoother must improve horizontal position over raw INS
    @test drms(fgo_res) < ins_drms
    # batch smoother should be no worse than the causal EKF (within a small margin)
    @test drms(fgo_res) <= 1.20 * drms(ekf_res)
    # smoother covariance should be no larger than filter covariance at t = 1
    @test fgo_res.P[1,1,1] <= ekf_res.P[1,1,1] * (1 + 1e-6)
end

@testset "fgo interfaces & options" begin
    @test fgo(ins,mag_1_c,itp_mapS)                            isa FILTres
    @test fgo(ins,mag_1_c,map_cache;core=true)                 isa FILTres
    @test fgo(ins,mag_1_c,itp_mapS;R=(1,10))                   isa FILTres
    @test fgo(ins,mag_1_c,itp_mapS;der_mapS,map_alt)           isa FILTres
    @test fgo(ins,mag_1_c,itp_mapS;n_iter=1)                   isa FILTres
    @test fgo(ins,mag_1_c,itp_mapS;n_iter=8,silent=false)      isa FILTres
    @test run_filt(traj,ins,mag_1_c,itp_mapS,:fgo;run_crlb=false) isa MagNav.FILTout
end
