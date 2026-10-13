# Changelog

## 2026-03-18

- Created a stand-alone `cgd_bear/` slide mini-deck for BEAR results.
- Added local copied inputs for:
  - the 11 datasets used in the paper,
  - a stand-alone Cochrane mixture slide,
  - the first 8 panels of Figure 1,
  - a results-summary slide with numeric ranges,
  - a full-slide version of the Figure 2 right panel.
- Switched the primary slide source to `slides.Rmd` rendered to PDF via
  Beamer, in line with the default `presentation-style` workflow.
- Kept all new code and rendered artifacts confined to `cgd_bear/`.

## 2026-03-21

- Copied the full contents of `../BEAR/cgd_bear/` into
  `cgd_replications_mar2026/` so the imported BEAR material remains
  self-contained in this repository.
- Appended the BEAR results slides from the copied mini-deck to
  `cgd_replications_mar2026.Rmd`, keeping the existing front half of the CGD
  presentation intact.
- Updated `render.R` and `README.md` to treat
  `cgd_replications_mar2026.Rmd` as the main deck rendered from the project
  root.

## 2026-03-22

- Added a separate `render_pptx.R` workflow that converts the Beamer deck to a
  text-first PowerPoint for Google Slides editing without changing the PDF
  render path.
- Added `R/pptx_helpers.R` to rewrite Beamer-only markup into a
  PowerPoint-friendly intermediate, including preserving Markdown bullet
  hierarchy and converting slide divider blocks into normal slides.
- Updated `build_figures.R` to save BEAR figure assets as both PDF and PNG so
  the PowerPoint export can embed the figures instead of dropping them.
- Updated `README.md` to document the new `.pptx` build command and its rough
  conversion goal.
- Added a parallel modern Beamer deck
  `cgd_replications_mar2026_modern.Rmd` plus `theme_cgd_modern.tex`, keeping
  the original deck unchanged while introducing a reusable house style.
- Added `render_modern.R` to build the styled PDF variant from the project
  root.
- Moved section-divider styling and dark image-slide treatment into shared
  macros so the modern deck does not need per-slide color settings.
- Refined the modern theme by removing the frametitle underline, tightening
  title spacing, and converting dark section/image slides plus plot slides to
  true frame-level wrappers so their backgrounds and text render correctly.
- Moved the section-card title block higher on the slide so divider slides sit
  closer to the top third rather than the lower middle.
- Added a little more top padding above ordinary frametitles in the modern
  deck so text-slide titles do not crowd the top edge.

## 2026-03-23

- Simplified `cgd_replications_mar2026_modern.Rmd` toward Markdown-first slide
  source by replacing avoidable raw `itemize` blocks with normal Markdown
  bullets while keeping only the Beamer-specific layout wrappers that still
  matter.
- Reworked the "Data Used In The Paper" slide so the dataset table is centered
  explicitly and its explanatory text is attached as a compact table note
  rather than free text at the bottom of the frame.
- Tightened the BEAR overview slide and removed extra table row spacing so the
  modern deck now renders without LaTeX overfull/underfull frame warnings in
  the final `xelatex` pass.
- Reorganized the folder around the active modern workflow: moved render/build
  scripts into `scripts/`, moved the non-modern deck and its outputs into
  `legacy/`, removed obsolete `slides.*` reference files plus unused local TeX
  helpers, and deleted transient LaTeX/R Markdown build artefacts.
- Removed `keep_tex` from both deck sources so normal renders no longer leave
  `.tex`, `.aux`, `.nav`, `.snm`, `.toc`, or `.vrb` clutter behind.
- Updated `R/plots.R` to mirror the BEAR mixture-plot alignment change for the
  corrected density curve, deriving `aligned_corrected_fz` from older cached
  inputs when needed so `cochrane` and `other10_panels` regenerate with the
  corrected curve aligned to the selected density above the significance
  threshold.

## 2026-04-03

- Updated the standalone bimodal production-function figure workflow in
  `production_function/` so its study-design step now follows the intended
  narrative: large effects are designed for 80% power, while small effects use
  the sample size implied by assuming an effect size of `1`.
- Replaced the bimodal figure's second panel with a planned-SE design visual,
  while leaving the active modern deck pointed at the existing
  Cochrane-inspired production-function slide.
- Recalibrated the bimodal standalone figure after checking the implied `|z|`
  distribution: the earlier strong-effect share left the 80%-power hump hidden
  under the weak-effect mass near zero, so the strong-effect mixture weight was
  increased to make panel 4 visibly reflect the bimodal SNR story.
- Tuned that calibration back down to a `60/40` strong-weak split once the
  hump was visible, and added small panel annotations reporting the simulated
  p-hacking share and omitted-significant share.
