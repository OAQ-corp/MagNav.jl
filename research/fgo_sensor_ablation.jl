##* Sensor-error factor ablation for FGO MagNav (factorial "각 경우의 수" study)
# A simulated flight with heading variation is corrupted with KNOWN scalar
# magnetometer sensor errors:
#   - heading error   Δ_head(t) = a1 cos(ψ) + b1 sin(ψ)  [quantum/OPM heading error]
#   - hard-iron bias  Δ_bias(t) = m · û_body(t)          [fluxgate vector bias]
# The batch FGO is then run with each combination of sensor-error factors
# {none, heading, fluxgate, both} × {L2, Huber}, and we report both the
# navigation error (DRMS) and how well each factor RECOVERS its injected truth.
#
# This is the differentiator vs a grid/point-mass estimator (which carries only
# 2-D position): the continuous factor graph jointly estimates the sensor-error
# states and returns a sensor calibration as a by-product.
#
# Usage: julia --project=. research/fgo_sensor_ablation.jl

using MagNav
using CSV, DataFrames
using LinearAlgebra, Statistics
using Random: seed!

seed!(2) # for reproducibility

##* simulated flight with heading variation (N_waves gives S-turns → yaw sweep)
mapS = get_map(MagNav.namad) # large low-res map, good for simulation
xyz  = create_XYZ0(mapS;
                   alt       = 1000,
                   dt        = 0.1,
                   t         = 600,   # 10 min
                   v         = 68,
                   N_waves   = 3,     # heading excitation
                   cor_sigma = 1.0,   # small FOGM catch-all
                   fogm_sigma = 1.0,
                   silent    = true)
traj = xyz.traj
ins  = xyz.ins
N    = traj.N
itp_mapS = map_interpolate(mapS)
date = get_years(2023,154)

mag_clean = xyz.mag_1_c # compensated scalar (referenced to the map along truth)

##* inject KNOWN sensor errors ------------------------------------------------
(_,_,psi) = dcm2euler(traj.Cnb,:body2nav)

# heading error truth [nT]
a1_true =  12.0
b1_true =  -8.0
d_head  = a1_true .* cos.(psi) .+ b1_true .* sin.(psi)

# hard-iron bias truth (body frame) [nT]
m_true = [15.0, -10.0, 6.0]
ub     = zeros(3,N)
for t = 1:N
    v       = MagNav.igrf(date,traj.alt[t],traj.lat[t],traj.lon[t],Val(:geodetic))
    ub[:,t] = traj.Cnb[:,:,t]' * (v ./ norm(v))
end
d_bias = [dot(m_true,ub[:,t]) for t = 1:N]

mag_corrupt = mag_clean .+ d_head .+ d_bias
println("injected heading error RMS: ",round(sqrt(mean(d_head.^2)),digits=2)," nT")
println("injected bias    error RMS: ",round(sqrt(mean(d_bias.^2)),digits=2)," nT")
println("heading (yaw) span: ",round(rad2deg(maximum(psi)-minimum(psi)),digits=0)," deg")

##* filter model
(P0,Qd,R) = create_model(traj.dt,traj.lat[1];fogm_sigma=1.0,fogm_tau=600.0)

##* horizontal position DRMS [m]
function drms(fr)
    dn = dlat2dn.(ins.lat .+ fr.x[1,:] .- traj.lat, traj.lat)
    de = dlon2de.(ins.lon .+ fr.x[2,:] .- traj.lon, traj.lat)
    sqrt(mean(dn.^2 .+ de.^2))
end
ins_drms = sqrt(mean(dlat2dn.(ins.lat .- traj.lat, traj.lat).^2 .+
                     dlon2de.(ins.lon .- traj.lon, traj.lat).^2))

##* recovered sensor-error coefficients (median over the smoothed trajectory)
function recovered(fr, n_harm, cal_bias)
    a1 = n_harm >= 1 ? median(fr.x[19,:]) : NaN
    b1 = n_harm >= 1 ? median(fr.x[20,:]) : NaN
    m  = cal_bias ? median(fr.x[18+2n_harm+1:18+2n_harm+3,:],dims=2)[:] : fill(NaN,3)
    return (a1,b1,m)
end

##* factorial ablation --------------------------------------------------------
cases = [ #  name                 n_harm  cal_bias
    ("baseline (no sensor)",           0,  false),
    ("heading (n=1)",                  1,  false),
    ("heading (n=2)",                  2,  false),
    ("fluxgate bias",                  0,  true ),
    ("heading+fluxgate (n=1)",         1,  true ),
    ("heading+fluxgate (n=2)",         2,  true ),
]

results = DataFrame(method=String[],robust=String[],drms=Float64[],
                    a1=Float64[],b1=Float64[],mx=Float64[],my=Float64[],mz=Float64[])

println("\nINS (no aiding) DRMS: ",round(ins_drms,digits=1)," m")
println("truth: a1=$a1_true b1=$b1_true  m=$m_true\n")

for robust in (:none, :huber)
    println("=== robust = $robust ===")
    for (name,nh,cb) in cases
        fr = fgo_sensor(ins,mag_corrupt,itp_mapS;P0=P0,Qd=Qd,R=R,
                        core=false,n_harm=nh,cal_bias=cb,robust=robust,n_iter=8)
        d  = drms(fr)
        (a1,b1,m) = recovered(fr,nh,cb)
        push!(results,(name,String(robust),d,a1,b1,m[1],m[2],m[3]))
        println(rpad(name,26)," DRMS = ",rpad(round(d,digits=1),7)," m",
                nh>=1 ? "  a1=$(round(a1,digits=1)) b1=$(round(b1,digits=1))" : "",
                cb    ? "  m=$(round.(m,digits=1))" : "")
    end
    println()
end

##* summary
println("=== factorial results ===")
show(results;allrows=true,allcols=true)
println()
out_csv = joinpath(@__DIR__,"fgo_sensor_ablation_results.csv")
CSV.write(out_csv,results)
println("\nresults written to $out_csv")
