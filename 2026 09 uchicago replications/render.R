# Render the Chicago seminar from its canonical source and the sibling BEAR
# checkout. Run from this talk directory with Rscript --vanilla render.R.
library(rmarkdown)

render("optimism.Rmd",
       output_file = "2026-09-uchicago-scientific-optimism.pdf",
       knit_root_dir = getwd(), clean = TRUE)
