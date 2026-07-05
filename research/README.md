# Factor Graph Optimization for Airborne Magnetic Navigation

Research extension to **MagNav.jl** that reformulates airborne magnetic anomaly
navigation as **factor graph optimization (FGO)** — batch maximum a posteriori
(MAP) estimation — and extends it with online Tolles-Lawson compensation and
physically-modeled scalar-magnetometer sensor-error factors.

Branch: `claude/fgo-problem-research-bllgbr` · all results below are produced by
the CI workflow `.github/workflows/fgo_research.yml` on real SGL 2020 flight data
and reproducible simulations.

---

## 1. What was built

| File | Lines | What it is |
|---|---:|---|
| `src/fgo.jl` | 514 | `fgo` — batch MAP smoother. Two equivalent solvers: iterated **RTS** (`solver=:rts`) and global **sparse Gauss–Newton / QR** (`solver=:gn`, square-root SAM). Robust Huber/Cauchy IRLS kernels. Reuses the existing Pinson model (`get_Phi`/`get_H`/`get_h`). |
| `src/fgo_online.jl` | 257 | `fgo_online` — batch FGO with **Tolles-Lawson coefficients as factor-graph variables** (joint aeromagnetic compensation + navigation; the batch analog of `ekf_online`). |
| `src/fgo_sensor.jl` | 272 | `fgo_sensor` — appends **physically-modeled sensor-error states**: OPM heading error (Fourier series in the sensor–field angle θ: light shift ∝cos θ, nonlinear Zeeman ∝cos 2θ), fluxgate hard-iron bias (`m·û_body`), linear drift, and dead-zone measurement weighting (`R/|sin 2θ|²`). |
| `src/eval_filt.jl` | +34 | `run_filt` dispatch for `:fgo` and `:fgo_online` with `solver`/`robust`/`n_iter` options. |
| `src/MagNav.jl` | +5 | include + export `fgo`, `fgo_online`, `fgo_sensor`; add `SparseArrays` dep. |
| `test/test_fgo.jl` | 254 | structure, accuracy-vs-EKF/INS, GN↔RTS agreement, robust-kernel, `fgo_online`, and `fgo_sensor` tests (registered in `runtests.jl`). |
| `examples/fgo_example.jl` | 65 | runnable EKF-vs-FGO demo on the bundled simple dataset. |
| `research/fgo_benchmark.jl` | 181 | real SGL **Flt1003** DRMS benchmark across all methods. |
| `research/paper_baseline.jl` | — | line 1007.06: our FGO-online (static + sliding-window TL) vs Hager et al. (2026) cited DRMS. |
| `research/paper_impl.jl` | — | **re-runs** the paper's online EKF+TL+NN (`ekf_online_nn`) cold start on line 1007.06 — a genuine reproduced baseline (Mag 4 40.0 m, Mag 5 17.5 m). |
| `research/fgo_sensor_ablation.jl` | 154 | factorial sensor-error ablation with injected-truth recovery. |
| `research/fgo_tracks.jl` | 131 | geographic map+track and position-error figures. |
| `.github/workflows/fgo_research.yml` | — | CI: test suite + all three research scripts on every push. |
| `docs/src/nav.md` | +41 | API documentation sections. |

**Theory in one line.** For the linear-Gaussian Pinson error model the factor
graph is a chain, so the MAP estimate equals the fixed-interval (RTS) smoother;
the novelty is not the smoothing but **modeling sensor-error physics as graph
variables estimated jointly with navigation** — which a position-only grid /
point-mass estimator structurally cannot do.

---

## 2. Results (real SGL Flt1003, line 1003.02, Eastern_395 map, 63 min)

Horizontal position **DRMS** [m], lower is better:

| Method | DRMS | Runtime |
|---|---:|---:|
| INS (no aiding) | 114.6 | — |
| EKF (baseline) | 28.3 | 23 s |
| **FGO (RTS)** | **14.3** | 18 s |
| **FGO (RTS + Huber)** | **14.0** | 16 s |

**Batch solver check (10-min segment):** FGO-RTS 18.4 m vs global sparse GN/QR
19.4 m — the two solvers converge to the same MAP estimate (RTS is ~2× faster on
the chain).

**Online Tolles-Lawson (uncompensated cabin Mag 4):**

| Method | DRMS |
|---|---:|
| EKF-online | **diverged (2.8×10⁵ m)** |
| FGO-online | 60.1 |
| **FGO-online + Huber** | **22.6** |

→ Under an uncompensated magnetometer the causal EKF-online diverges while batch
FGO-online with a robust kernel holds 22.6 m — better than the compensated-stinger EKF.

---

## 3. Sensor-error factor ablation (simulated, Eastern_395, injected truth)

Cumulative factors; INS reference 31.1 m. Injected: heading k1=10/k2=6 nT,
hard-iron m=[15,−10,6] nT, drift 0.02 nT/s, dead-zone heteroscedastic noise.

| Model | DRMS | notes |
|---|---:|---|
| baseline (no sensor states) | 36.6 | worse than INS — unmodeled error corrupts aiding |
| + heading (θ, n=2) | 19.1 | |
| + dead-zone weighting | 19.2 | inert here (level flight never enters a dead zone) |
| + fluxgate bias | 8.4 | |
| **+ drift (full model)** | **4.8** | −87% vs baseline; below INS |

**Parameter recovery (full model vs truth).** Drift 0.019 vs 0.020 ✓ and bias
m_y −10.5 vs −10 ✓ recover cleanly; heading k1/k2 and bias m_x/m_z are
**observability-limited** because the simulated flight sweeps the sensor–field
angle θ by only 12° (level flight at ~70° inclination). Honest finding: the
**navigation gain is robust, but clean sensor calibration recovery needs wider
attitude excitation** — an observability result worth formalizing.

---

## 4. How to run

```julia
using MagNav
# ... build traj, ins, meas, itp_mapS, (P0,Qd,R) as in examples/fgo_example.jl
filt = fgo(ins, meas, itp_mapS; P0, Qd, R, n_iter=5)          # batch MAP smoother
filt = fgo(ins, meas, itp_mapS; solver=:gn)                    # sparse GN/QR solver
filt = fgo(ins, meas, itp_mapS; robust=:huber)                # robust kernel
res  = fgo_online(ins, meas, flux, itp_mapS, x0_TL, P0, Qd, R) # + TL compensation
res  = fgo_sensor(ins, meas, itp_mapS; n_harm=2, cal_bias=true,# + sensor-error
                  drift=true, dead_zone=true)                  #   factors
# or via the standard pipeline:
run_filt(traj, ins, meas, itp_mapS, :fgo; P0, Qd, R)
```

Reproduce the studies:
```
julia --project=. research/fgo_benchmark.jl        # real Flt1003 DRMS table
julia --project=. research/fgo_sensor_ablation.jl  # factorial sensor ablation
julia --project=. research/fgo_tracks.jl           # map + track + error figures
```

---

## 5. Four research thrusts (status)

1. **Batch MAP FGO vs EKF on real data** — ✅ Flt1003: 28.3 → 14.0 m.
2. **"Textbook" sparse GN/QR solver** — ✅ square-root SAM form, matches RTS.
3. **Tolles-Lawson factors (joint compensation)** — ✅ EKF-online diverges, FGO-online 22.6 m.
4. **Physical OPM sensor-error factors (heading/dead-zone/bias/drift) + robust** — ✅ ablation 36.6 → 4.8 m, with an honest observability caveat.

## 5b. Comparison to the online EKF+TL+NN cold-start literature

We compare against the online EKF + Tolles-Lawson + neural-network cold-start
calibration of Hager et al. (2026, arXiv 2603.08265), on that paper's primary
line 1007.06, full 87 min, uncompensated cabin magnetometers, DRMS after a
10-min warm-up. Two scripts:

- `research/paper_baseline.jl` runs **our** methods (FGO-online with static and
  sliding-window / adaptive TL) and prints the paper's published DRMS as a cited
  reference line.
- `research/paper_impl.jl` actually **re-runs the paper's filter family**: the
  MagNav.jl `ekf_online_nn` — an online EKF with the TL basis as NN input
  features and the NN weights carried as EKF states, learned online from a cold
  start (the reference implementation of the SGL/AFIT online NN-in-EKF lineage
  the paper builds on).

**Reproducing the cold start took care, and the failure modes were instructive.**
A naive cold start of `ekf_online_nn` diverges; getting it into the paper's band
required three fixes, each addressing a distinct, diagnosable failure:

1. **Bias handling** — the NN compensation must represent only the aircraft
   interference (the core + map field is already supplied by `get_h`), and its DC
   offset is initialized from onboard data (median of `mag_uc − get_h` over the
   first minutes). Without this the first residual is the full interference DC and
   the Kalman gain spikes to a NaN divergence.
2. **Feature design** — the scalar `mag_uc` must be **excluded** from the NN
   inputs (TL A-matrix only). It carries the map anomaly, so feeding it to the
   compensation NN lets the network subtract the very signal we navigate on,
   collapsing observability (residual → 0 while position drifts to km scale — Mag 4
   at 5.8 km with `max|resid|` only 78 nT). This is exactly the instability the
   paper's natural-gradient stabilization is designed to prevent; here it is
   prevented structurally, through the feature set.
3. **Covariance** — de-trust the map through the cold-start transient
   (`meas_var = 12²`) and set the NN weight process noise by hand.

**Reproduced result (our re-run of the online EKF+TL+NN, cold start, line 1007.06,
full length; INS 318 m, EKF on compensated Mag 1 ≈ 20 m for reference):**

| Magnetometer | paper TL-only | paper TL+NN | **EKF+TL+NN re-run (ours)** | **FGO-online win 5min +Huber (ours)** |
|---|---:|---:|---:|---:|
| Mag 4 (uncompensated) | 58 m | 37 m | **40.0 m** | **32.6 m** |
| Mag 5 (uncompensated) | 15 m | 14 m | **17.5 m** | **14.2 m** |

Reading it honestly: our re-run of the online EKF+TL+NN lands **in the paper's
published cold-start band** — beating their TL-only and within a few metres of
their tuned TL+NN. It is a fair reproduction, not an exact one: we do not have
their released architecture / natural-gradient stabilization, so we sit a few
metres above their tuned filter. It now serves as a genuine, re-run baseline
rather than a cited number. Notably, our **sliding-window FGO-online** (adaptive
TL, fixed-lag smoother, *no neural network*) matches or beats that reproduced
EKF+TL+NN on the same line — see §5c. Exact numbers are in the CI artifacts
`paper_impl_results.csv` and `paper_baseline_results.csv`.

## 5c. Sliding-window (fixed-lag) FGO-online vs static-batch TL

A single batch solves one static TL coefficient set for the whole flight, which
underfits time-varying interference over a long line. Running `fgo_online` as an
**iSAM2-style fixed-lag smoother** (kwargs `win`/`overlap`; each window commits
its leading `stride` and carries the full state + covariance forward as the prior
for the next) makes the TL compensation **adapt** along the flight. On line
1007.06 (full 87 min) this recovers the long-line performance dramatically:

| Method (line 1007.06, full length) | Mag 4 | Mag 5 |
|---|---:|---:|
| FGO-online **batch** (static TL) | 123.7 m | 68.1 m |
| FGO-online **win 5 min** (adaptive TL) | 37.0 m | 15.1 m |
| FGO-online **win 2 min** (adaptive TL) | 45.9 m | 17.1 m |
| **FGO-online win 5 min + Huber** | **32.6 m** | **14.2 m** |
| — paper TL+NN (Hager et al. 2026) | 37 m | 14 m |

The fixed-lag window takes the static batch from 124 → 32.6 m (Mag 4) and
68 → 14.2 m (Mag 5), **matching or beating the paper's cold-start TL+NN with no
neural network** — the adaptive-TL relinearization plays the role their online NN
plays. Produced by `research/paper_baseline.jl`.

## 6. Reproducibility

CI runs the full test suite (Julia LTS + latest) plus all research scripts on
every push and uploads the result CSVs as artifacts. Figures are generated from
the same runs. Nothing here depends on private data — SGL 2020 and the Ottawa
maps download automatically via lazy artifacts.

## 7. Limitations & next steps

- **Breadth**: results are strongest on one line (1003.02); a journal-grade study
  needs multiple lines/flights and Monte-Carlo statistics.
- **Baselines**: add MPF and a reproduction of the grid/point-mass MMSE estimator
  for a like-for-like comparison.
- **Theory**: add CRLB/PCRB comparison and formalize the θ-sweep observability
  condition (Fisher information of the heading factor).
- **Robust**: demonstrate the kernels on real map-error / uncharted-anomaly
  outliers (they are near-inert on smooth injected errors).
- **Sensor calibration**: rerun with a wide-θ maneuver profile to convert the
  weak parameter recovery into clean recovery.

See the commit history on this branch for the full development trail.
