# Changelog

## 2026-04-28

- Moved the active interactive smooth production-function app to
  `replications/field/production_function_smooth_16x9.html`, with legacy
  redirects left in this folder.
- Added `replications/field/production_function_bimodal_16x9.html` as a
  redirect to the smooth app until a separate bimodal interactive version is
  restored.
- Revised the smooth app controls by removing the null-hypothesis and
  replication-precision sliders, replacing the SE multiplier with a sample-size
  multiplier, and fixing replication precision at `1x`.
- Recalibrated the weak-effects, low-power, and high-p-hacking presets to
  produce roughly 50% replication success among published significant
  originals under a longer-tailed smooth SNR mixture.
- Narrowed the `|SNR|`, raw `|z|`, nudged `|z|`, and published `|z|`
  histograms to the `0..6` display range.

## 2026-04-27

- Added `production_function_smooth_16x9.html`, a standalone interactive
  16:9 version of the smooth production-function figure.
- Reworked the interactive version from the initial bimodal draft to the
  smoothly decreasing Cochrane-style production function, with controls for
  null hypotheses, weak-effect share, study precision, p-hacking,
  non-significant publication, and replication precision.
- Added top-row preset buttons for weak-effects, low-power, and high-p-hacking
  scenarios, each calibrated to produce about a 50% replication-success rate.
- Kept the significance threshold fixed at `1.96` and left the old
  `production_function_bimodal_16x9.html` path as a redirect.

## 2026-04-03

- Reworked the bimodal production-function simulation so study design is no
  longer an independent SE draw: large effects are tested at 80% power, while
  small effects use the sample size implied by assuming an effect size of `1`.
- Replaced the old panel-2 power histogram in the bimodal figure with a
  design-step visual showing the planned standard-error distribution under
  those rules.
- Increased the strong-effect mixture weight in the bimodal variant after
  checking the generated `|z|` histograms: at the earlier 25% setting the
  expected hump around the 80%-power SNR was real but hidden under the larger
  weak-effect spike near zero.
- Lowered that calibration from `70%` strong to `60%` strong / `40%` weak,
  which still leaves a visible shoulder in panel 4 while restoring more weak
  studies to the mixture.
- Added minimal in-panel annotations to the p-hacking and publication panels so
  they report the simulated hacked-share and omitted-significant-share values.
- Updated the production-function scripts and README to use the current
  `cgd_replications_mar2026/production_function/figures/` output path from the
  repository root.

## 2026-03-23

- Added a standalone exploratory workflow for a six-panel "Production
  Function of Empirical Research" figure.
- Anchored the illustration to the fitted `Cochrane` mixture, while using
  a calibrated latent effect-size mixture plus heterogeneous standard errors
  to generate a roughly similar `|z|` distribution.
- Exported both vector PDF and slide-ready PNG outputs for paper and 16:9
  presentation use.
- Reworked the figure to use shorter titles, top-right note boxes, fixed-break
  histogram outlines instead of boundary-biased kernel densities, and a more
  optimistic Cochrane-inspired mixture so the power panel has visible mass near
  both `0` and `1`.
- Removed the in-panel annotation boxes and global title, retitled the panels
  more compactly, and corrected the p-hacking panel so moved values land in
  the `p < 0.05` region (`|z| > 1.96`) rather than below significance.
- Tightened plot margins, increased text sizes, and slightly reduced export
  dimensions to make the six-panel layout read larger with less whitespace.
- Added a separate bimodal-effect variant where roughly 75% of effects are
  small and 25% cluster around a large-effect bump, exported as separate PDF
  and PNG files.
