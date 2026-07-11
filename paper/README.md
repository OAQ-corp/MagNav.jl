# TAES manuscript draft

`taes_fgo_magnav.tex` — IEEE Transactions on Aerospace and Electronic Systems
draft: *Factor-Graph Aeromagnetic Compensation for Airborne Magnetic-Anomaly
Navigation — A Neural-Network-Free Sliding-Window Alternative to Online EKF
Calibration.*

All quantitative claims come from the reproducible experiments on this branch
(`research/*.jl`, run in CI):

| Paper item | Source script | Key numbers |
|---|---|---|
| Table I (batch FGO vs EKF) | `research/fgo_benchmark.jl` | INS 114.6, EKF 28.3, FGO 14.3/14.0 m |
| Table II (cold-start line 1007.06) | `research/paper_baseline.jl`, `research/paper_impl.jl` | FGO win5min+Huber 32.6/14.2; EKF+TL+NN 40.0/17.5; paper 37/14 |
| Table III (breadth, 5 lines) | `research/fgo_breadth.jl` | FGO wins 8/9; EKF diverges on Mag 4 |
| Sensor-error factors (sim) | `research/fgo_sensor_ablation.jl` | 36.6 → 4.8 m (−87%) |
| Observability discussion | `research/observability*.jl`, `research/OBSERVABILITY.md` | sweet spot; exogeneity rule (honest negatives) |

## Building

Requires `IEEEtran.cls` (https://www.michaelshell.org/tex/ieeetran/) and a TeX
distribution (TeX Live / MiKTeX). Not installed in this environment.

```
pdflatex taes_fgo_magnav
pdflatex taes_fgo_magnav   # second pass for cross-references
```

References are inline `\bibitem`s (no BibTeX pass needed).

## Status / TODO before submission

- Authors, affiliations, acknowledgments.
- Figures: geographic tracks + position-error plots (`research/fgo_tracks.jl`
  outputs `fgo_map_track.png`, `fgo_pos_error.png`) can be dropped in as
  `\includegraphics`.
- Verify/complete the Hager et al. (2026) citation metadata against the published
  version.
- Optional: Monte-Carlo statistics, MPF / grid-MMSE baselines, real sensor-error
  validation (see paper §VII limitations).
