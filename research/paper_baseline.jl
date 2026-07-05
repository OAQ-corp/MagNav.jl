##* Comparison vs the online EKF+TL+NN family (Hager et al. 2026 / Gnadt [8])
# The paper "Airborne MagNav with NN-Augmented Online Calibration" (Hager et al.,
# arXiv 2603.08265) augments an EKF with Tolles-Lawson (TL) coefficients AND
# neural-network (NN) weights, learned ONLINE from a cold start (no calibration
# flight, no NN pre-training). It explicitly extends Gnadt [8] — which is
# MagNav.jl's own `ekf_online_nn`. This script builds a REPRESENTATIVE cold-start
# reproduction of that family and puts it next to our batch FGO (which already
# carries the TL coefficients as factor-graph nodes).
#
# Same real data as the paper: SGL 2020, primary line 1007.06, uncompensated
# cabin magnetometers, DRMS evaluated after a 10-min warm-up (paper convention).
#
# Methods:
#   EKF (compensated Mag 1)       reference upper baseline
#   EKF-online  (TL, cold-start)  TL-only online calibration  (paper Fig. 8b)
#   EKF-online-NN (cold-start)    online EKF + NN calibration (paper family)   [baseline]
#   FGO-online  (TL, batch)       OUR batch TL-factor smoother                  [ours]
#
# NOTE: this is a representative reproduction — the paper's exact NN architecture,
# feature set, natural-gradient tuning and noise matrices are not publicly
# released, so absolute numbers are indicative, not bit-exact.
#
# Usage: julia --project=. research/paper_baseline.jl

using MagNav
using CSV, DataFrames, Flux
using LinearAlgebra, Statistics
using Random: seed!
seed!(33)

df_dir    = joinpath(@__DIR__,"..","examples","dataframes")
df_flight = DataFrame(CSV.File(joinpath(df_dir,"df_flight.csv")))
df_flight[!,:flight]   = Symbol.(df_flight[!,:flight])
df_flight[!,:xyz_type] = Symbol.(df_flight[!,:xyz_type])
df_flight[!,:xyz_file] = String.(df_flight[!,:xyz_file])
for (i,flight) in enumerate(df_flight.flight)
    flight in (:Flt1007,) || continue
    df_flight.xyz_file[i] = MagNav.sgl_2020_train(flight)
end
df_map = DataFrame(CSV.File(joinpath(df_dir,"df_map.csv")))
df_map[!,:map_name] = Symbol.(df_map[!,:map_name])
df_map[!,:map_file] = String.(df_map[!,:map_file])
for (i,map_name) in enumerate(df_map.map_name)
    df_map.map_file[i] = MagNav.ottawa_area_maps(map_name)
end
df_nav = DataFrame(CSV.File(joinpath(df_dir,"df_nav.csv")))
df_nav[!,:flight]   = Symbol.(df_nav[!,:flight])
df_nav[!,:map_name] = Symbol.(df_nav[!,:map_name])

flight = :Flt1007
line   = 1007.06                      # paper's primary line
@info("loading $flight")
xyz  = get_XYZ(flight,df_flight;silent=true)
ind  = get_ind(xyz,line,df_nav)
# restrict to the first 25 min of the line (10-min warm-up + 15-min evaluation);
# keeps the sampling rate intact and bounds the augmented-EKF covariance memory
# (the full 87-min line would make the NN filter's P_out ~6 GB → OOM on CI)
t0   = xyz.traj.tt[ind][1]
ind  = ind .& (xyz.traj.tt .<= t0 + 1500.0)
map_name = df_nav[(df_nav.flight.==flight).&(df_nav.line.==line),:map_name][1]
mapS = get_map(map_name,df_map)

traj = get_traj(xyz,ind)
ins  = get_ins( xyz,ind;N_zero_ll=1)
(map_val,itp_mapS) = get_map_val(mapS,traj;return_itp=true)
flux = xyz.flux_d(ind)
N    = traj.N
println("line $line: N=$N, ~$(round(N*traj.dt/60,digits=1)) min, map=$map_name")

# horizontal position DRMS [m], evaluated after a warm-up window
function drms(fo; warm=600.0)
    m = (traj.tt .- traj.tt[1]) .>= warm
    dn = dlat2dn.(fo.lat[m] .- traj.lat[m], traj.lat[m])
    de = dlon2de.(fo.lon[m] .- traj.lon[m], traj.lat[m])
    sqrt(mean(dn.^2 .+ de.^2))
end
ins_drms = let m=(traj.tt.-traj.tt[1]).>=600.0
    sqrt(mean(dlat2dn.(ins.lat[m].-traj.lat[m],traj.lat[m]).^2 .+
              dlon2de.(ins.lon[m].-traj.lon[m],traj.lat[m]).^2)) end

results = DataFrame(method=String[],mag=String[],drms=Float64[])
log!(name,mag,fo) = (d=drms(fo); push!(results,(name,mag,d));
    println(rpad(name,26)," ",mag," DRMS(>10min) = ",round(d,digits=1)," m"); d)

##* cold-start TL model (generic init, no calibration flight)
n_TL     = 19                                   # perm3+ind6+eddy9+bias1
x0_TL    = zeros(n_TL)
TL_sigma = fill(1.0, n_TL)                       # loose prior (cold start)
P0_TL    = Matrix(Diagonal(fill(1.0, n_TL)))
(P0,Qd,R) = create_model(traj.dt,traj.lat[1];
                         init_pos_sigma=0.1,init_alt_sigma=1.0,init_vel_sigma=1.0,
                         meas_var=5^2,fogm_sigma=3,fogm_tau=180,
                         vec_states=false,TL_sigma=TL_sigma,P0_TL=P0_TL)
(P0n,Qdn,Rn) = create_model(traj.dt,traj.lat[1];   # nav-only model for plain EKF
                            init_pos_sigma=0.1,init_alt_sigma=1.0,init_vel_sigma=1.0,
                            meas_var=5^2,fogm_sigma=3,fogm_tau=180)

println("\nINS (no aiding) DRMS(>10min) = ",round(ins_drms,digits=1)," m\n")

# stinger reference: EKF on the pre-compensated Mag 1 (best case; only mag_1_c
# exists in the dataset — cabin mags 2-5 are uncompensated only)
try
    fo = run_filt(traj,ins,xyz.mag_1_c[ind],itp_mapS,:ekf;P0=P0n,Qd=Qdn,R=Rn,
                        core=true,run_crlb=false); log!("EKF (Mag1 compensated)","Mag 1",fo)
catch e; @warn("EKF Mag1 failed",e) end
println()

for magsym in (:mag_4_uc, :mag_5_uc)
    mag_uc = getfield(xyz,magsym)[ind]
    tag    = replace(String(magsym),"mag_"=>"Mag ","_uc"=>"")
    println("=== $tag (uncompensated cabin magnetometer) ===")

    # TL-only online calibration, cold start  (paper Fig. 8b family)
    try
        fo = run_filt(traj,ins,mag_uc,itp_mapS,:ekf_online;P0=P0,Qd=Qd,R=R,
                            flux=flux,x0_TL=x0_TL,core=true,run_crlb=false)
        log!("EKF-online (TL)",tag,fo)
    catch e; @warn("ekf_online failed",e) end

    # online EKF + NN calibration, cold start (untrained NN)  [paper family]
    try
        A_nn = create_TL_A(flux;terms=[:permanent,:induced,:eddy])
        x    = [mag_uc  A_nn]
        (_,_,x_norm) = norm_sets(x)
        (yb,ys,_)    = norm_sets(mag_uc)
        Nf   = size(x_norm,2)
        m    = MagNav.get_nn_m(Nf;hidden=[5])           # small NN, NOT pre-trained (cold start)
        n_w  = length(Flux.destructure(m)[1])
        P0_nn    = Matrix(Diagonal(fill(1.0,n_w)))
        nn_sigma = fill(0.05,n_w)
        (P0N,QdN,RN) = create_model(traj.dt,traj.lat[1];
                                    init_pos_sigma=0.1,init_alt_sigma=1.0,init_vel_sigma=1.0,
                                    meas_var=5^2,fogm_sigma=3,fogm_tau=180,
                                    vec_states=false,TL_sigma=nn_sigma,P0_TL=P0_nn)
        fo = run_filt(traj,ins,mag_uc,itp_mapS,:ekf_online_nn;P0=P0N,Qd=QdN,R=RN,
                            x_nn=x_norm,m=m,y_norms=(yb,ys),core=true,run_crlb=false)
        log!("EKF-online-NN (cold)",tag,fo)
    catch e; @warn("ekf_online_nn failed",e) end

    # OUR batch FGO with TL factor nodes, cold start
    try
        fo = run_filt(traj,ins,mag_uc,itp_mapS,:fgo_online;P0=P0,Qd=Qd,R=R,
                            flux=flux,x0_TL=x0_TL,core=true,run_crlb=false)
        log!("FGO-online (TL, ours)",tag,fo)
        fo = run_filt(traj,ins,mag_uc,itp_mapS,:fgo_online;P0=P0,Qd=Qd,R=R,
                            flux=flux,x0_TL=x0_TL,robust=:huber,core=true,run_crlb=false)
        log!("FGO-online +Huber (ours)",tag,fo)
    catch e; @warn("fgo_online failed",e) end
    println()
end

println("=== summary (DRMS after 10-min warm-up, line $line) ===")
show(results;allrows=true,allcols=true); println()
CSV.write(joinpath(@__DIR__,"paper_baseline_results.csv"),results)
println("\nreference (paper, cold-start Nh=5, line 1007.06): Mag4≈37 m, Mag5≈14 m")
