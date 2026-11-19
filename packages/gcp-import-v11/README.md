# Global Consciousness Project import (V11 research add-on)

This is **real, published historical 15-minute network aggregate data**, transcribed from the original GCP egg-summary table (Jan 1, 1999; first 8 hours). It is **not raw 1-second device output**. Source: https://www.global-mind.org/data/eggsummary/1999/summary-1999-01-01.html

Files:
- `gcp_1999_01_01_network_15min.csv`: 32 rows of original composite successes/trials and displayed absolute Z, plus independently recomputed signed Z and cumulative `Z²-1` for an exploratory trace. The latter calculation is based on ideal binomial variance and **does not replicate GCP's empirically normalized event statistic**.
- `gcp_observations.pl`: SWI-Prolog facts and basic numeric invariants.
- `gcp_sources.csv`: official archive locations and what was actually retrieved.

## Caveats
- Official page values are aggregates over 15-minute windows; do not treat them as per-second trials.
- Source displayed Z values are unsigned; `recomputed_signed_z` uses the sign of deviation from the theoretical half-trial expectation.
- The original experiment has a contested interpretation; correlation or random fluctuations alone do not establish a global consciousness mechanism.
- No GCP 2.0 full data were downloaded. Its official form requires selecting a group and time range.
- No statistical significance claims are made from this selected small slice.

## Formal candidate invariants
- `0 <= Ones <= Trials` per block.
- Trial counts positive and integer.
- If modeling a fair independent RNG, reference theoretical expectation `E[Ones] = Trials/2` and `Var[Ones] = Trials/4`. This is a null model, not guaranteed by hardware.
- Any global-event correlation requires preregistered windows and matched controls.
