##* Sensor-error factor ablation for FGO MagNav (factorial "각 경우의 수" study)
# A simulated flight over a HIGH-RESOLUTION survey map, with heading variation,
# is corrupted with KNOWN, physically-motivated scalar-magnetometer errors of an
# optically-pumped / quantum sensor (Oelsner et al. 2022):
#   - heading error   Δ_head = k1 cos θ + k2 cos 2θ   (light shift + nonlinear
#                                                       Zeeman), θ = ∠(axis, B)
#   - hard-iron bias  Δ_bias = m · û_body(t)          (fluxgate vector bias)
#   - linear drift    Δ_drift = d · t                 (electronics drift)
#   - dead zones      heteroscedastic noise ∝ 1/|sin 2θ| (signal collapses near
#                                                          θ = 0°/90°)
# The batch FGO is run with each combination of sensor-error factors and we
# report navigation error (DRMS) plus how well each factor RECOVERS its truth.
#
# The sensor optical axis is body-x (nose): as the aircraft yaws, θ sweeps a wide
# range, so the heading error / dead zones are observable (a body-down axis would
# leave θ ≈ const at the field inclination — unobservable, absorbed by a bias).
#
# Usage: julia --project=. research/fgo_sensor_ablation.jl

using MagNav
using CSV, DataFrames
using LinearAlgebra, Statistics
using Random: seed!

seed!(2)

##* high-resolution survey map (Eastern_395); fall back to coarse NAMAD
try
    df_map = DataFrame(CSV.File(joinpath(@__DIR__,"..","examples","dataframes","df_map.csv")))
    df_map[!,:map_name] = Symbol.(df_map[!,:map_name])
    df_map[!,:map_file] = String.(df_map[!,:map_file])
    for i in eachindex(df_map.map_name)
        df_map.map_name[i] == :Eastern_395 || continue
        df_map.map_file[i] = MagNav.ottawa_area_maps(df_map.map_name[i])
    end
    global mapS     = get_map(:Eastern_395,df_map)
    global map_used = "Eastern_395 (high-res survey)"
catch e
    @warn("Eastern_395 unavailable, using NAMAD",e)
    global mapS     = get_map(MagNav.namad)
    global map_used = "NAMAD (coarse)"
end
println("map: ",map_used)

##* simulated flight with heading variation over the map
try
    global xyz = create_XYZ0(mapS; alt=mapS.alt, dt=0.1, t=240, v=68,
                             N_waves=2, attempts=500, cor_sigma=1.0,
                             fogm_sigma=1.0, silent=true)
catch e
    @warn("trajectory fit on survey map failed, using NAMAD",e)
    global mapS     = get_map(MagNav.namad)
    global map_used = "NAMAD (coarse)"
    global xyz = create_XYZ0(mapS; alt=1000, dt=0.1, t=600, v=68, N_waves=3,
                             cor_sigma=1.0, fogm_sigma=1.0, silent=true)
end
traj = xyz.traj
ins  = xyz.ins
N    = traj.N
itp_mapS  = map_interpolate(mapS)
date      = get_years(2023,154)
mag_clean = xyz.mag_1_c

##* sensor-field geometry (optical axis = body-x / nose)
axis   = [1.0,0.0,0.0]
u_body = zeros(3,N)
theta  = zeros(N)
for t = 1:N
    v           = MagNav.igrf(date,traj.alt[t],traj.lat[t],traj.lon[t],Val(:geodetic))
    u_body[:,t] = traj.Cnb[:,:,t]' * (v ./ norm(v))
    theta[t]    = acos(clamp(dot(axis,u_body[:,t]),-1,1))
end

##* inject KNOWN sensor errors ------------------------------------------------
k1_true = 10.0   # light shift        (cos θ)  [nT]
k2_true =  6.0   # nonlinear Zeeman   (cos 2θ) [nT]
d_head  = k1_true .* cos.(theta) .+ k2_true .* cos.(2 .* theta)

m_true  = [15.0,-10.0,6.0]                       # hard-iron bias [nT]
d_bias  = [dot(m_true,u_body[:,t]) for t = 1:N]

dr_true = 0.02                                   # drift [nT/s]
d_drift = dr_true .* (0:N-1) .* traj.dt

A       = clamp.(abs.(sin.(2 .* theta)),0.05,1.0) # dead-zone signal amplitude
dz_noise = (1.0 ./ A) .* randn(N)                 # heteroscedastic (∝ 1/A) noise

mag_corrupt = mag_clean .+ d_head .+ d_bias .+ d_drift .+ dz_noise
println("θ span: ",round(rad2deg(maximum(theta)-minimum(theta)),digits=0)," deg")
println("injected RMS [nT]  head=",round(sqrt(mean(d_head.^2)),digits=1),
        " bias=",round(sqrt(mean(d_bias.^2)),digits=1),
        " drift=",round(sqrt(mean(d_drift.^2)),digits=1),
        " deadzone-noise=",round(sqrt(mean(dz_noise.^2)),digits=1))

##* filter model
(P0,Qd,R) = create_model(traj.dt,traj.lat[1];fogm_sigma=1.0,fogm_tau=600.0)

function drms(fr)
    dn = dlat2dn.(ins.lat .+ fr.x[1,:] .- traj.lat, traj.lat)
    de = dlon2de.(ins.lon .+ fr.x[2,:] .- traj.lon, traj.lat)
    sqrt(mean(dn.^2 .+ de.^2))
end
ins_drms = sqrt(mean(dlat2dn.(ins.lat .- traj.lat, traj.lat).^2 .+
                     dlon2de.(ins.lon .- traj.lon, traj.lat).^2))

function recovered(fr, nh, cb, dr)
    a1 = nh >= 1 ? median(fr.x[19,:]) : NaN   # cos θ  coeff  (light shift)
    a2 = nh >= 2 ? median(fr.x[21,:]) : NaN   # cos 2θ coeff  (nonlinear Zeeman)
    ib = 18 + 2nh
    m  = cb ? median(fr.x[ib+1:ib+3,:],dims=2)[:] : fill(NaN,3)
    id = 18 + 2nh + (cb ? 3 : 0)
    d  = dr ? median(fr.x[id+1,:]) : NaN
    return (a1,a2,m,d)
end

##* factorial ablation --------------------------------------------------------
cases = [ # name                     n_harm cal_bias drift dead_zone
    ("baseline (no sensor)",              0, false, false, false),
    ("heading (geometry, n=2)",           2, false, false, false),
    ("heading + dead-zone wt",            2, false, false, true ),
    ("heading + dz + fluxgate",           2, true,  false, true ),
    ("heading + dz + flux + drift",       2, true,  true,  true ),
]

results = DataFrame(method=String[],robust=String[],drms=Float64[],
                    a1=Float64[],a2=Float64[],mx=Float64[],my=Float64[],
                    mz=Float64[],drift=Float64[])

println("\nmap: $map_used | N=$N | INS DRMS: ",round(ins_drms,digits=1)," m")
println("truth: k1=$k1_true k2=$k2_true  m=$m_true  drift=$dr_true\n")

for robust in (:none, :huber)
    println("=== robust = $robust ===")
    for (name,nh,cb,dr,dz) in cases
        fr = fgo_sensor(ins,mag_corrupt,itp_mapS;P0=P0,Qd=Qd,R=R,core=false,
                        n_harm=nh,heading=:geometry,axis=axis,cal_bias=cb,
                        drift=dr,dead_zone=dz,robust=robust,n_iter=8)
        d  = drms(fr)
        (a1,a2,m,dd) = recovered(fr,nh,cb,dr)
        push!(results,(name,String(robust),d,a1,a2,m[1],m[2],m[3],dd))
        println(rpad(name,30)," DRMS=",rpad(round(d,digits=1),7)," m",
                nh>=1 ? "  k̂1=$(round(a1,digits=1)) k̂2=$(round(a2,digits=1))" : "",
                cb    ? "  m̂=$(round.(m,digits=1))" : "",
                dr    ? "  d̂=$(round(dd,digits=3))" : "")
    end
    println()
end

println("=== factorial results ===")
show(results;allrows=true,allcols=true)
println()
out_csv = joinpath(@__DIR__,"fgo_sensor_ablation_results.csv")
CSV.write(out_csv,results)
println("\nresults written to $out_csv")
