# Production Function Figure

The R scripts build illustrative six-panel figures showing a stylised
production function of empirical research. Run from the talks repository root:

```sh
Rscript "2026 03 cgd replications/production_function/plot_production_function_v1.R"
Rscript "2026 03 cgd replications/production_function/plot_production_function_bimodal_v1.R"
```

Outputs go to `2026 03 cgd replications/production_function/figures/`.
Only `production_function_cochrane_slide.png`, used by the CGD talk, is tracked;
other exports and the obsolete HTML redirects remain local and are ignored.

The alternative bimodal variant uses a rule-based study-design step: large
effects are tested at 80% power, while small effects inherit the sample size
implied by designing for an assumed effect size of `1`.
