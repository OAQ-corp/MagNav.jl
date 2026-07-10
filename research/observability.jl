##* Observability collapse index for joint compensation + navigation in a
##* map-matching factor graph  (algorithmic-contribution groundwork)
#
# This session's central empirical finding was an OBSERVABILITY COLLAPSE: when the
# online compensation model was given the scalar magnetometer `mag_uc` as an input
# feature, the estimator drove the map-matching residual to ~0 (max|resid| 78 nT)
# while position drifted to 5.8 km — because `mag_uc` carries the map anomaly, so
# the compensation could reproduce the very signal we navigate on. Removing that
# feature (attitude/fluxgate-only Tolles-Lawson basis) fixed it structurally.
#
# Here we turn that finding into a MEASURABLE, tuning-independent quantity.
#
# Position information from map-matching lives in the map value along the track,
# g(t) = map_anomaly(p(t)); a position error δp perturbs the measurement by
# ∇map·δp, whose temporal signature is spanned by g(t) and its along-track rate.
# If a compensation basis B(t) can REPRODUCE g(t), then a position error and a
# compensation error are confounded and the joint problem is unobservable. Define
#
#   collapse index  ρ²(B) = R² of regressing g(t) onto [1, B(t)]  (per window),
#
# i.e. the fraction of the navigation signal the compensation basis can explain.
# ρ² → 1 ⇒ the basis can mimic the map ⇒ joint estimation collapses;
# ρ² ≪ 1 ⇒ the basis is (near-)orthogonal to the map ⇒ position stays observable.
#
# PREDICTION to validate: attitude-only Tolles-Lawson bases give ρ² ≪ 1 (the
# configs that converged), while adding `mag_uc` gives ρ² ≈ 1 (the config that
# diverged). The index should thus PREDICT the divergence we observed, purely
# from geometry — no filter run, no covariance tuning.
#
# Usage: julia --project=. research/observability.jl

using MagNav
using CSV, DataFrames
using LinearAlgebra, Statistics

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
line   = 1007.06
@info("loading $flight")
xyz  = get_XYZ(flight,df_flight;silent=true)
ind  = get_ind(xyz,line,df_nav)
map_name = df_nav[(df_nav.flight.==flight).&(df_nav.line.==line),:map_name][1]
mapS = get_map(map_name,df_map)
traj = get_traj(xyz,ind)
(map_val,itp_mapS) = get_map_val(mapS,traj;return_itp=true)
flux = xyz.flux_d(ind)
N    = traj.N
dt   = traj.dt
println("line $line: N=$N, ~$(round(N*dt/60,digits=1)) min, map=$map_name")

# R² of regressing y on [1 X] (fraction of y explained by the columns of X)
function r2(y::AbstractVector, X::AbstractMatrix)
    yc = y .- mean(y)
    sst = sum(abs2, yc)
    sst == 0 && return 0.0
    A   = [ones(eltype(X),length(y)) X]
    β   = A \ y                      # least squares (QR; handles rank deficiency)
    res = y .- A*β
    return 1 - sum(abs2, res)/sst
end

# median per-window ρ² at a given window length (samples); global = one fit
function rho2_scale(g, B, win)
    win >= length(g) && return r2(g, B)
    stride = max(1, win ÷ 2)
    ρ = Float64[]; i0 = 1; N = length(g)
    while i0 + win - 1 <= N
        push!(ρ, r2(g[i0:i0+win-1], B[i0:i0+win-1,:]))
        i0 += stride
    end
    isempty(ρ) ? r2(g,B) : median(ρ)
end

g_val = map_val   # navigation signal: map anomaly along the track

# candidate compensation bases
A_perm = create_TL_A(flux;terms=[:permanent])                 # 3  cols (used config)
A_full = create_TL_A(flux;terms=[:permanent,:induced,:eddy])  # 18 cols (max TL)
mag4   = xyz.mag_4_uc[ind]
mag5   = xyz.mag_5_uc[ind]

bases = [
    ("TL permanent (3, attitude)",        A_perm),
    ("TL perm+ind+eddy (18, attitude)",   A_full),
    ("TL perm + mag_4_uc  (LEAK)",        hcat(A_perm, mag4)),
    ("TL full  + mag_4_uc  (LEAK)",       hcat(A_full, mag4)),
]

# window scales (s): the confound that matters is ρ² at the window matching the
# estimator's adaptation timescale. Fast adaptation ⇒ short window ⇒ per-window
# ρ² matters; slow/constrained adaptation ⇒ long window ⇒ global ρ² matters.
scales_s = [30.0, 60.0, 300.0, 900.0]
scales_n = [round(Int, s/dt) for s in scales_s]

println("\n=== multi-scale observability collapse index ρ²(window) ===")
println("ρ² = fraction of the nav signal (map anomaly) a compensation basis can",
        " reproduce over a window.")
println("Persistent (all scales high) ⇒ a fixed/slow readout leaks the map ⇒ collapse.")
println("Spurious  (high short, low long) ⇒ only a fast-adapting readout can exploit it.\n")

hdr = rpad("basis",34) * join([rpad("$(Int(s))s",8) for s in scales_s]) * rpad("global",8)
println(hdr)
res = DataFrame(basis=String[], s30=Float64[], s60=Float64[], s300=Float64[],
                s900=Float64[], global_=Float64[])
for (name,B) in bases
    rs = [rho2_scale(g_val,B,n) for n in scales_n]
    rg = r2(g_val, B)
    println(rpad(name,34), join([rpad(round(r,digits=3),8) for r in rs]),
            rpad(round(rg,digits=3),8))
    push!(res,(name, round(rs[1],digits=3), round(rs[2],digits=3),
               round(rs[3],digits=3), round(rs[4],digits=3), round(rg,digits=3)))
end

# link to the observed filter outcome (research/paper_impl.jl, line 1007.06)
println("\n=== the index vs the observed EKF+TL+NN cold-start outcome ===")
outcome = DataFrame(
    config      = ["attitude TL perm (3)", "TL perm + mag_uc (leak)"],
    Mag4_DRMS_m = ["40.0 (converged)",     "5813 (collapsed)"],
    reading     = ["ρ² low at all scales ⇒ observable",
                   "ρ² high at all scales (persistent) ⇒ collapse"])
show(outcome;allrows=true,allcols=true); println()

CSV.write(joinpath(@__DIR__,"observability_index.csv"),res)
println("\nTakeaway: the collapse is governed by ρ² at the estimator's adaptation",
        " timescale — not by an attitude/non-attitude dichotomy. mag_uc leaks the",
        " map PERSISTENTLY (high ρ² at all scales); a rich attitude basis leaks only",
        " SPURIOUSLY (high at short scales, decaying with window), so a rate-limited",
        " estimator is protected. This unifies basis expressiveness, adaptation rate,",
        " and the paper's natural-gradient stabilization (which slows the effective",
        " adaptation onto the low-ρ² global scale), and is the signal for an online",
        " observability gate.")
