# Render fixed-dimension BEAR figures for the slide deck.
# Run from 2026 03 cgd replications/.

library(ggplot2)
source("R/plots.R")

dir.create("fig", showWarnings = FALSE)

slide_data <- load_slide_data()

save_slide_plot <- function(stem, plot, width, height, dpi = 300) {
  ggsave(
    paste0("fig/", stem, ".pdf"),
    plot = plot,
    width = width,
    height = height,
    units = "cm",
    device = grDevices::cairo_pdf
  )

  ggsave(
    paste0("fig/", stem, ".png"),
    plot = plot,
    width = width,
    height = height,
    units = "cm",
    dpi = dpi
  )
}

save_slide_plot(
  "cochrane",
  plot_cochrane(slide_data),
  width = 29,
  height = 10.8
)

save_slide_plot(
  "other10_panels",
  plot_other10_panels(slide_data),
  width = 29,
  height = 11.6
)

save_slide_plot(
  "sign_rep",
  plot_sign_rep(slide_data),
  width = 29,
  height = 10.6
)
