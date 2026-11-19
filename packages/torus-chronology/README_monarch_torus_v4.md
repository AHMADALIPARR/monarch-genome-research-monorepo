# MKULTRA effects and torus cognition — research prototype v4

## Interpretation
This extension joins a **historical source-mention layer** with a **wholly synthetic model** of post-experience cognition. It does NOT derive clinical correlations from historical sources, reconstruct pre-experiment cognition of MKULTRA survivors, substantiate MONARCH allegations, or prove quantum consciousness.

* `mkultra_effect_associations.csv`: 28 lexical associations across the existing 22 stories. These are search candidates, NOT adjudicated psychological effects, outcome prevalence, correlation coefficients, or independent corroboration. Check each claim against original passages before upgrading its status.
* `monarch_historical_facts.pl`: source-attributed Prolog facts generated from the existing seed.
* `monarch_torus_analysis.pl`: SWI-Prolog source-link predicates, torus metrics, Shannon entropy, probability mixture, entropy-bound checks.
* `monarch_torus_sim.c`: C11 deterministic synthetic trajectories for baseline, modeled impact, modeled recovery (12 observations each), circular cumulative coordinates, 8x8 torus occupation, entropy, baseline distance and operational bottleneck-region counts.
* `torus_synthetic_trace.csv`: 36 synthetic time steps, not participant measurements.
* `torus_entropy_metrics.csv`: computed per-phase descriptive values for these illustrative simulated points only.

## Model
Let X_t=(agency,orientation,distress,function) on an illustrative 0..4 scale. Let ΔA and ΔD be consecutive changes in agency and distress. With periods P_A=P_D=4, cumulative coordinates are

θ_t = 2π (Σ_{i≤t} ΔA_i / P_A) mod 2π
φ_t = 2π (Σ_{i≤t} ΔD_i / P_D) mod 2π.

These live on a flat torus S¹×S¹. The geodesic distance from baseline is sqrt(d_circle(θ,θ₀)²+d_circle(φ,φ₀)²). The specified "throat region" is simply the chosen neighborhood |θ−π|_circle<π/4 and |φ−π|_circle<π/4; a flat torus has **no geometric wormhole throat**. Changing that region changes occupancy results. The mapping is lossy: unequal cognitive states may share toroidal coordinates. The torus cannot reconstruct an unobserved original consciousness.

Shannon entropy H=-Σ pᵢ log₂ pᵢ for 64 torus occupancy bins obeys 0≤H≤6 bits. This bound is a mathematical theorem, not evidence of quantum superposition. A classical convex mixture p_mix=(1−λ)p_base+λp_recovery has an entropy that can be computed, but is not a physical quantum state. Physical superposition would require a specified Hilbert space, coherent state preparation and experimental observables distinguishing interference from classical mixtures; none are provided here.

## Reproduce

```sh
cc -std=c11 -O2 -Wall -Wextra -Werror monarch_torus_sim.c -lm -o monarch_torus_sim
./monarch_torus_sim
swipl -q -s monarch_torus_analysis.pl -g example_checks -t halt
swipl -q -s monarch_torus_analysis.pl -g "findall(ID,source_supported(ID),IDs),writeln(IDs)" -t halt
```

C11 compiled and numerical assertions passed in the authoring environment. SWI-Prolog is not installed here; its runtime predicates have not been verified with SWI-Prolog.

## Evidence constraints
Historical research source: US Senate 1977 hearing: https://www.govinfo.gov/app/details/CHRG-95shrg96408O
Cameron historical review: https://pmc.ncbi.nlm.nih.gov/articles/PMC10443815/
APA clinical PTSD guideline: https://www.apa.org/ptsd-guideline/
Quantum cognition review: https://doi.org/10.1146/annurev-psych-033020-123501

Do not fit any experimental-causal, entropy-consciousness, or treatment-efficacy claims to these synthetic samples. Baselines, controls, validated instruments, participant consent, and sufficient N would be prerequisites for clinical estimates.
