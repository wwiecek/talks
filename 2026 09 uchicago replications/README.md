# Chicago seminar

`optimism.Rmd` is the canonical presentation source; `2026-09-uchicago-scientific-optimism.pdf` is the
rendered talk. Continue editing this source rather than creating versions
for different slide counts. `theme_optimism.tex` supplies the Beamer theme.
The original CGD source and PDF are in `../2026 03 cgd replications/`.

From this directory, with the BEAR repository checked out as `../../BEAR`:

```sh
Rscript --vanilla render.R
```

The talk follows the 28 main slides in `spec.md`, with an added opening slide on
the quality of empirical science, ending with the opinionated
metascience summary. The optional backups and a separate replication-programmes
section are not included. Slide 19 retains the conditional-distribution
calculations; it can move to backup if the model section needs shortening.

Use the paper's terminology, notation and sentences, compressing rather than
rephrasing. The opening slides follow the introduction in `paper/optimism.tex`.
Footnotes are reserved for references, definitions and necessary figure notes.

## Inputs and generated outputs

- `../../BEAR/BEAR.rds`: paper corpus counts, example rows and empirical histograms.
- The live BEAR homepage, checked 24 September 2026: 24 datasets,
  12.5 million results and 7,476 meta-analyses (not study units).
- `../../BEAR/R/paper_selection.R`: the 16 paper corpora.
- `../../BEAR/paper/tables/table2.tex` and `table3.tex`: displayed numerical summaries.
  These take precedence over numerical ranges in the manuscript prose.
- `../../BEAR/mixtures/*.rds`: saved fits for curves; no models are refitted.
- `../../BEAR/explore/subgroups/fits.rds`: the paper's trial-phase data and saved fits
  for the three decreasing-distribution panels.
- `../../BEAR/R/plot_mixture.R`, `R/fit_density_calc.R`, `R/psr.R` and
  `paper/plot_figure_pos_gap.R`: histogram and probability-curve conventions.

The render creates `corpus_summary.csv`, `example_rows.csv`, and the PDF
figures under `figures/`. The illustrative convolution on slide 13 is not
an empirical fit. Slide 20 reproduces the histogram layers on slide 11.
The selection slide excludes replication datasets; other results retain them.
The saved replication fits do not fix the selection parameter at 1.
Both grids show ten corpora in two rows of five; plot text uses
DejaVu Sans Mono, a console-style font available in the render environment.
Dashed corrected densities are rescaled above 1.96, as in the paper.
The histograms use all local combined-file rows rather than the thinned
fitting inputs. Study counts are not deduplicated across corpora, and the local
combined data can differ from the downloadable release.

Access instructions were verified against the live
[BEAR website](https://witold.xyz/BEAR/getting-started.html) and
[GitHub releases](https://github.com/wwiecek/BEAR/releases).
