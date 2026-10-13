# Render the UChicago agents talk from this directory.
library(rmarkdown)

render("agents.Rmd", output_file = "2026-09-uchicago-ai-agents.pdf",
       knit_root_dir = getwd(), clean = TRUE)
