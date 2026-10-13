# Render the active modern-styled Beamer deck.
# Run from the project root.

library(rmarkdown)

old_wd <- setwd("2026 03 cgd replications")
on.exit(setwd(old_wd), add = TRUE)

source("scripts/build_figures.R")
render("cgd_replications_mar2026_modern.Rmd",
  output_file = "2026-03-cgd-gold-standard-science.pdf",
  clean = TRUE
)

unlink("cgd_replications_mar2026_modern.knit.md", force = TRUE)
unlink("cgd_replications_mar2026_modern_files",
  recursive = TRUE, force = TRUE
)
