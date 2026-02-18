# MATLAB Port

This folder contains two MATLAB migration tracks for MagNav.jl.

## 1) Curated/validated ports (`+magnav`)

These functions were manually translated to MATLAB syntax and are the recommended starting point:

- `+magnav/euler2dcm.m`
- `+magnav/dcm2euler.m`
- `+magnav/correct_Cnb.m`

Example:

```matlab
addpath(genpath('matlab'));

dcm = magnav.euler2dcm(0.01, -0.02, 1.0);
[roll, pitch, yaw] = magnav.dcm2euler(dcm);
```

## 2) Full mechanical draft ports (`+magnav_fullport`)

To cover the entire Julia `src/` codebase quickly, mechanical draft MATLAB functions are generated under:

- `+magnav_fullport/*.m` (299 functions)

These drafts preserve structure and equations as much as possible, but they are **not yet fully MATLAB-idiomatic or validated**.

Generate/re-generate drafts with:

```bash
python matlab/port_julia_to_matlab.py
```

## Suggested completion workflow

1. Use `+magnav_fullport` as reference for each module.
2. Promote each function to `+magnav` once manually corrected and tested.
3. Add numerical parity tests against Julia outputs (same inputs, tolerance checks).
4. Migrate by subsystem: DCM/INS → maps → compensation/modeling → EKF/MPF/NEKF → plotting.
