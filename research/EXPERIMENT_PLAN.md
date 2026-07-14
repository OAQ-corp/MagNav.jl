# Experiment Plan — Statistical Rigor Pass (for IEEE TAES)

Goal: close the two Tier-1 reviewer levers from the red-team re-review by adding
the estimator-consistency and statistical-significance evidence a TAES reviewer
expects, without weakening any existing (honest) claim.

## 0. Why (reviewer gaps this closes)

| Gap (red-team) | Test that closes it |
|---|---|
| No NEES/NIS consistency check | **B** NEES (state) + NIS (innovation) |
| No ±2σ covariance bands | **C** ±2σ envelope on position error |
| Single-run DRMS behind count-based "8/8" | **A** Monte-Carlo DRMS with 95% CIs |
| Headline vs imperfect reimplementation, no error bars | **A** error bars on the breadth bars |

## 1. Feasibility (already verified)

`fgo_online` / `fgo_online_window` and the EKF baseline return
`FILTres(x, P, resid, …)` with per-epoch state `x[nx,N]`, covariance
`P[nx,nx,N]`, and measurement residuals. So the estimator covariance and the
innovation are available directly — no solver change needed. `nx` includes the
3-axis position-error block, so a 2-DOF horizontal-position marginal is a simple
slice of `P`.

## 2. Tests

### A. Monte-Carlo DRMS with confidence intervals
- **Design.** For each trial draw a random initial INS error `x0 ~ N(0, P0)` and a
  fresh measurement-noise realization; TL coefficients stay cold-start (zero).
  Run all three estimators (online-TL EKF, EKF+TL+NN, FGO window) on the same
  draw so comparisons are paired.
- **Coverage.** The 4 counted lines × {Mag 4, Mag 5} = 8 cases. `N` seeds per case.
- **Metrics.** mean DRMS ± 95% t-interval; paired win-rate P(FGO < both baselines).
- **Reframes** the "8/8" claim as "lowest mean DRMS with non-overlapping 95% CI on
  k/8 cases" plus a per-seed win rate — a statistical statement, not a single run.
- **Outputs.** ± columns added to Table IV (or a companion table); error bars added
  to `fig_breadth`.

### B. Filter consistency — NEES + NIS
- **NEES (is the reported covariance credible?).** Horizontal-position 2-DOF
  normalized error `ε_t = e_pos,tᵀ (P_pos,t)⁻¹ e_pos,t`, averaged over time and over
  the `N` MC trials → ANEES, compared to the two-sided 95% χ²₂ consistency interval.
  ANEES ≫ 2 ⇒ over-confident (optimistic covariance); ≪ 2 ⇒ conservative.
- **NIS (are innovations consistent?).** Per scalar measurement
  `ν_t² / S_t`, `S_t = H_t P_t H_tᵀ + R`, 1-DOF, averaged → compared to the 95% χ²₁
  interval. Detects a mis-scaled `R` or an over-tight map factor.
- **Comparison.** FGO smoothed covariance vs the EKF, so the plot shows which
  estimator is self-consistent.
- **Coverage.** Primary line 1007.06 (both mags) + batch line 1003.02.
- **Outputs.** `fig_consistency`: NEES-vs-time and NIS-vs-time with χ² bounds; a
  summary line (ANEES, % of epochs inside the band).

### C. ±2σ covariance envelope
- One representative run (batch line 1003.02, clean compensated sensor): North and
  East position error vs time with the estimator ±2σ band from `P_pos`. Shows the
  reported uncertainty actually contains the error.
- **Output.** `fig_sigma` (2-panel N/E error with ±2σ).

### D. (optional, if CI budget allows)
- No-Huber FGO column in the breadth table (isolate the robust kernel across all
  lines, not only 1007.06).
- `L_w` / `L_o` sensitivity with ± bands.

## 3. Honesty guardrail
NEES/NIS may reveal the estimator is optimistic (common for a smoother with a
robust kernel and a strong map factor). If so we **report it and fix it in the
open**: inflate `Q`/scale `R` until ANEES enters the χ² band, and document the
adjustment. A consistent-after-tuning result is publishable; a hidden inconsistent
one is not. Either outcome is reported, never suppressed.

## 4. Implementation steps
1. `research/fgo_montecarlo.jl` — seed loop; collects DRMS, per-epoch NEES, NIS,
   and ±2σ traces; writes CSVs (and prints to the CI log for provenance).
2. Extend `.github/workflows/fgo_research.yml` with a Monte-Carlo job; scope `N`
   and reuse each line's loaded `XYZ` across seeds; log wall-clock and `N`.
3. Figures: `fig_consistency`, `fig_sigma`, and error bars on `fig_breadth`
   (in `make_figures.py` / `plot_tracks.py`), all in the existing dataviz style.
4. Manuscript: new Results subsection "Consistency and statistical significance";
   add the MC ± values and the NEES/NIS/±2σ evidence; update the abstract to state
   the results are Monte-Carlo with CIs; remove the matching sentence from the
   Conclusion's limitations. Update `research/README.md` provenance.

## 5. Compute scope and the one decision needed
A fixed-lag smoother over `N` seeds × 8 cases is the cost driver. Proposed scope:
- **Consistency (B) + ±2σ (C):** `N = 30` on 1007.06 (both mags) and 1003.02.
- **MC-DRMS (A):** `N = 30` on all 4 lines × 2 mags.

`N = 30` gives usable 95% intervals while keeping the CI job bounded. If the job
runs too long, the fallback is `N = 20` (stated in the paper). Pushing `N = 100`
(tighter intervals, stronger claim) means a much longer CI job.

**Decision:** run at `N = 30` (recommended balance), or go to `N = 100` for
publication-grade intervals at the cost of a long CI run?

## 6. Expected impact
Closes Tier-1 #1 in full and Tier-1 #2 in part (error bars on the headline
margin). Estimated TAES accept probability ~30% → ~50%+, contingent on the
consistency result being clean (or cleanly tuned per §3).
