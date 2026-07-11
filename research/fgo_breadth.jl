##* FGO breadth study: is the sliding-window FGO advantage a one-line fluke?
#
# The headline FGO result (line 1007.06: window FGO ≈/> the online EKF+TL+NN, no
# neural network) needs to hold across lines, flights and maps to be paper-grade.
# Here we run the SAME cold-start Tolles-Lawson compensation model through a causal
# filter (ekf_online) and through the factor graph (fgo_online, fixed-lag window)
# on several long survey lines from the SGL 2020 flights, on the uncompensated
# cabin magnetometers Mag 4 and Mag 5. No neural network anywhere — the only
# difference between the two columns is causal EKF vs batch/window smoothing, so a
# consistent FGO advantage isolates the value of the factor-graph formulation.
#
# Reference points per line: INS (no aiding) and an EKF on the pre-compensated
# stinger Mag 1 (mag_1_c). DRMS after a 10-min warm-up (paper convention).
#
# Usage: julia --project=. research/fgo_breadth.jl

using MagNav
using CSV, DataFrames
using LinearAlgebra, Statistics
using Random: seed!
seed!(33)

MEAS_VAR = 12.0^2
FOGM_SIG = 3.0
FOGM_TAU = 180.0
TERMS    = [:permanent,:induced,:eddy,:bias]

# long full survey lines with uncompensated cabin mags, across flights & maps
LINES = [(:Flt1003,1003.02), (:Flt1003,1003.08),
         (:Flt1006,1006.08),
         (:Flt1007,1007.02), (:Flt1007,1007.06)]
flights = unique(first.(LINES))

df_dir    = joinpath(@__DIR__,"..","examples","dataframes")
df_flight = DataFrame(CSV.File(joinpath(df_dir,"df_flight.csv")))
df_flight[!,:flight]   = Symbol.(df_flight[!,:flight])
df_flight[!,:xyz_type] = Symbol.(df_flight[!,:xyz_type])
df_flight[!,:xyz_file] = String.(df_flight[!,:xyz_file])
for (i,fl) in enumerate(df_flight.flight)
    fl in flights || continue
    df_flight.xyz_file[i] = MagNav.sgl_2020_train(fl)
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

xyz_cache = Dict{Symbol,Any}()
getxyz(fl) = get!(()->get_XYZ(fl,df_flight;silent=true), xyz_cache, fl)

function drms(traj, lat, lon; warm=600.0)
    m  = (traj.tt .- traj.tt[1]) .>= warm
    dn = dlat2dn.(lat[m] .- traj.lat[m], traj.lat[m])
    de = dlon2de.(lon[m] .- traj.lon[m], traj.lat[m])
    sqrt(mean(dn.^2 .+ de.^2))
end

results = DataFrame(flight=Symbol[],line=Float64[],map=Symbol[],mag=String[],
                    INS=Float64[],EKF_online=Float64[],FGO_win=Float64[],EKF_Mag1=Float64[])

for (fl,line) in LINES
    xyz   = getxyz(fl)
    ind   = get_ind(xyz,line,df_nav)
    mname = df_nav[(df_nav.flight.==fl).&(df_nav.line.==line),:map_name][1]
    mapS  = get_map(mname,df_map)
    traj  = get_traj(xyz,ind)
    ins   = get_ins(xyz,ind;N_zero_ll=1)
    (_,itp) = get_map_val(mapS,traj;return_itp=true)
    flux  = xyz.flux_d(ind)
    nTL   = size(create_TL_A(flux;terms=TERMS),2)
    ins_d = drms(traj,ins.lat,ins.lon)
    (P0,Qd,R)    = create_model(traj.dt,traj.lat[1];init_pos_sigma=0.1,init_alt_sigma=1.0,
        init_vel_sigma=1.0,meas_var=MEAS_VAR,fogm_sigma=FOGM_SIG,fogm_tau=FOGM_TAU,
        vec_states=false,TL_sigma=fill(1.0,nTL),P0_TL=Matrix(Diagonal(fill(1.0,nTL))))
    (P0n,Qdn,Rn) = create_model(traj.dt,traj.lat[1];init_pos_sigma=0.1,init_alt_sigma=1.0,
        init_vel_sigma=1.0,meas_var=MEAS_VAR,fogm_sigma=FOGM_SIG,fogm_tau=FOGM_TAU)

    ekf1 = NaN
    try
        fo = run_filt(traj,ins,xyz.mag_1_c[ind],itp,:ekf;P0=P0n,Qd=Qdn,R=Rn,
                      core=true,run_crlb=false)
        ekf1 = drms(traj,fo.lat,fo.lon)
    catch e; @warn("EKF Mag1 failed for $fl $line",e) end

    println("\n$fl $line  ($mname, ~$(round(traj.N*traj.dt/60,digits=0)) min)  ",
            "INS=$(round(ins_d,digits=0)) m  EKF(Mag1)=$(round(ekf1,digits=1)) m")
    for magsym in (:mag_4_uc,:mag_5_uc)
        mag = getfield(xyz,magsym)[ind]
        tag = replace(String(magsym),"mag_"=>"Mag ","_uc"=>"")
        eko = NaN
        try
            fo = run_filt(traj,ins,mag,itp,:ekf_online;P0=P0,Qd=Qd,R=R,flux=flux,
                          x0_TL=zeros(nTL),terms=TERMS,core=true,run_crlb=false)
            eko = drms(traj,fo.lat,fo.lon)
        catch e; @warn("ekf_online failed for $fl $line $tag",e) end
        fgw = NaN
        try
            frw = fgo_online(ins,mag,flux,itp,zeros(nTL),P0,Qd,R;terms=TERMS,
                             core=true,win=300.0,overlap=90.0,robust=:huber)
            fo  = MagNav.eval_filt(traj,ins,frw)
            fgw = drms(traj,fo.lat,fo.lon)
        catch e; @warn("fgo_online window failed for $fl $line $tag",e) end
        push!(results,(fl,line,mname,tag,round(ins_d,digits=1),round(eko,digits=1),
                       round(fgw,digits=1),round(ekf1,digits=1)))
        println("  $tag  EKF-online=$(round(eko,digits=1))  FGO-win=$(round(fgw,digits=1)) m")
    end
end

println("\n=== FGO breadth: window FGO vs causal EKF-online, cold-start cabin mags ===")
show(results;allrows=true,allcols=true); println()
CSV.write(joinpath(@__DIR__,"fgo_breadth_results.csv"),results)
fin  = filter(r->isfinite(r.EKF_online) && isfinite(r.FGO_win), results)
wins = sum(fin.FGO_win .< fin.EKF_online)
println("\nFGO-window beats causal EKF-online on $wins/$(nrow(fin)) mag-line cases",
        " (same TL model, no neural network) — tests whether the factor-graph",
        " (batch/window smoothing) advantage generalizes across lines/flights/maps.")
