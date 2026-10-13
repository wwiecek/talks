# CGD Replications Slides

The March 2026 CGD talk uses `cgd_replications_mar2026_modern.Rmd` as its
source and `2026-03-cgd-gold-standard-science.pdf` as its saved presentation.
`theme_cgd_modern.tex` supplies the Beamer theme.

From the talks repository root:

```sh
Rscript "2026 03 cgd replications/scripts/render_modern.R"
```

The script rebuilds the imported BEAR figures from the compressed RDS inputs
in `data/`, using `scripts/build_figures.R` and `R/plots.R`, then renders the
PDF. The deck also uses committed images in `assets/`, `fig/` and
`production_function/figures/`.

To rebuild just the imported figures, run `Rscript scripts/build_figures.R`
from this talk directory. The production-function scripts are documented
in `production_function/README.md`.

The older Beamer and PowerPoint variants remain locally under `legacy/`
and are ignored by Git. The repository tracks the current talk and its inputs.
