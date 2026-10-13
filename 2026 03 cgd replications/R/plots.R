library(dplyr)
library(ggplot2)
library(scales)
library(tidyr)

add_aligned_corrected_curve <- function(density_df, c_star = 1.96) {
  if ("aligned_corrected_fz" %in% names(density_df)) {
    return(density_df)
  }

  density_df %>%
    group_by(dataset) %>%
    mutate(
      norm_const = median(corrected_fz[x > c_star] / fz[x > c_star], na.rm = TRUE),
      aligned_corrected_fz = corrected_fz / norm_const
    ) %>%
    ungroup() %>%
    select(-norm_const)
}

load_slide_data <- function() {
  list(
    dataset_summary = readRDS("data/dataset_summary.rds"),
    mixture_hist = readRDS("data/mixture_hist_inputs.rds"),
    mixture_density = readRDS("data/mixture_density_inputs.rds") %>%
      add_aligned_corrected_curve(),
    sign_rep_curves = readRDS("data/sign_rep_curves.rds"),
    results_ranges = readRDS("data/results_ranges.rds")
  )
}

slide_cols <- list(
  ink = "#172126",
  blue = "#2F5D73",
  blue_light = "#6E96A8",
  rust = "#9A5B2A",
  sand = "#E9E0D1",
  grid = "#D8D2C7",
  grey = "#666666"
)

mixture_x_breaks <- c(0, 1.96, 4, 6)
mixture_x_labels <- c("0", "1.96", "4", "6")

theme_bear_slide <- function(base_size = 14) {
  theme_minimal(base_size = base_size) +
    theme(
      text = element_text(color = slide_cols$ink),
      plot.title = element_text(face = "bold", size = rel(1.0)),
      plot.subtitle = element_text(size = rel(0.82), color = slide_cols$grey),
      axis.title = element_text(size = rel(0.82)),
      axis.text = element_text(size = rel(0.72)),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(color = slide_cols$grid, linewidth = 0.35),
      plot.margin = margin(6, 8, 6, 8),
      legend.position = "none"
    )
}

panel_mixture_plot <- function(
  hist_df,
  density_df,
  title = NULL,
  base_size = 13,
  hist_breaks = seq(0, 10, length.out = 25),
  show_assurance_label = TRUE
) {
  assurance_val <- unique(hist_df$assurance)[1]
  panel_title <- if (is.null(title)) unique(hist_df$panel_label)[1] else title

  plot <- ggplot(hist_df, aes(x = z, weight = weights)) +
    geom_vline(
      xintercept = 3.02,
      color = alpha(slide_cols$grey, 0.5),
      linetype = "22",
      linewidth = 0.55
    ) +
    geom_histogram(
      aes(y = after_stat(density)),
      breaks = hist_breaks,
      fill = slide_cols$blue,
      alpha = 0.22,
      colour = NA
    ) +
    geom_line(
      data = density_df,
      aes(x = x, y = aligned_corrected_fz),
      inherit.aes = FALSE,
      linewidth = 0.8,
      color = slide_cols$grey,
      linetype = "22"
    ) +
    geom_line(
      data = density_df,
      aes(x = x, y = fz),
      inherit.aes = FALSE,
      linewidth = 1.05,
      color = slide_cols$blue
    ) +
    coord_cartesian(xlim = c(0, 10), ylim = c(0, 0.6), expand = FALSE) +
    scale_x_continuous(
      breaks = mixture_x_breaks,
      labels = mixture_x_labels
    ) +
    labs(title = panel_title, x = "|z|", y = NULL) +
    theme_bear_slide(base_size = base_size) +
    theme(
      plot.title = element_text(size = rel(0.9), lineheight = 0.95),
      axis.text.y = element_blank(),
      axis.title.y = element_blank()
    )

  if (show_assurance_label) {
    plot <- plot +
      annotate(
        "label",
        x = 8.15,
        y = 0.545,
        label = paste0("Mean PoS = ", number(assurance_val, accuracy = 0.01)),
        size = 3.1,
        linewidth = 0,
        fill = alpha("white", 0.88),
        color = slide_cols$ink
      )
  }

  plot
}

plot_cochrane <- function(slide_data) {
  hist_df <- slide_data$mixture_hist %>% filter(dataset == "Cochrane")
  density_df <- slide_data$mixture_density %>% filter(dataset == "Cochrane")

  panel_mixture_plot(
    hist_df,
    density_df,
    title = "",
    base_size = 19,
    hist_breaks = seq(0, 10, length.out = 49),
    show_assurance_label = FALSE
  ) +
    labs(
      subtitle = "30,306 studies; 31% of results significant in the paper sample"
    ) +
    theme(
      plot.title = element_blank(),
      plot.subtitle = element_text(size = 12.5, margin = margin(b = 6)),
      axis.title.x = element_text(size = 13),
      axis.text.x = element_text(size = 11)
    )
}

plot_panel_grid <- function(slide_data, target_panel_type = "other10", ncol = 5, accent = slide_cols$blue) {
  ordered_df <- slide_data$mixture_hist %>%
    filter(.data$panel_type == .env$target_panel_type) %>%
    distinct(dataset, panel_rank, panel_label) %>%
    arrange(panel_rank) %>%
    mutate(panel_label = factor(panel_label, levels = panel_label))

  hist_df <- slide_data$mixture_hist %>%
    filter(.data$panel_type == .env$target_panel_type) %>%
    left_join(ordered_df, by = c("dataset", "panel_rank", "panel_label")) %>%
    mutate(panel_label = factor(panel_label, levels = levels(ordered_df$panel_label)))

  density_df <- slide_data$mixture_density %>%
    filter(.data$panel_type == .env$target_panel_type) %>%
    left_join(ordered_df, by = c("dataset", "panel_rank", "panel_label")) %>%
    mutate(panel_label = factor(panel_label, levels = levels(ordered_df$panel_label)))

  label_df <- hist_df %>%
    distinct(dataset, panel_label, assurance) %>%
    mutate(label = paste0("Mean PoS = ", number(assurance, accuracy = 0.01)))

  ggplot(hist_df, aes(x = z, weight = weights)) +
    geom_histogram(
      aes(y = after_stat(density)),
      breaks = seq(0, 10, length.out = 25),
      fill = accent,
      alpha = 0.22,
      colour = NA
    ) +
    geom_vline(
      xintercept = 3.02,
      color = alpha(slide_cols$grey, 0.45),
      linetype = "22",
      linewidth = 0.45
    ) +
    geom_line(
      data = density_df,
      aes(x = x, y = aligned_corrected_fz),
      inherit.aes = FALSE,
      linewidth = 0.8,
      color = slide_cols$grey,
      linetype = "22"
    ) +
    geom_line(
      data = density_df,
      aes(x = x, y = fz),
      inherit.aes = FALSE,
      linewidth = 1.05,
      color = accent
    ) +
    geom_label(
      data = label_df,
      aes(x = 5, y = 0.545, label = label),
      inherit.aes = FALSE,
      size = 3.0,
      linewidth = 0,
      fill = alpha("white", 0.88),
      color = slide_cols$ink
    ) +
    coord_cartesian(xlim = c(0, 10), ylim = c(0, 0.6), expand = FALSE) +
    scale_x_continuous(
      breaks = mixture_x_breaks,
      labels = mixture_x_labels
    ) +
    labs(x = "|z|", y = NULL) +
    facet_wrap(~panel_label, ncol = ncol) +
    theme_bear_slide(base_size = 13) +
    theme(
      strip.text = element_text(size = 10.5, face = "bold", lineheight = 0.92),
      axis.title.x = element_text(size = 10.5),
      axis.text.x = element_text(size = 9.5),
      axis.text.y = element_blank(),
      axis.title.y = element_blank(),
      panel.spacing = grid::unit(0.5, "lines")
    )
}

plot_other10_panels <- function(slide_data) {
  plot_panel_grid(slide_data, target_panel_type = "other10", ncol = 5, accent = slide_cols$blue)
}

plot_sign_rep <- function(slide_data) {
  curve_df <- slide_data$sign_rep_curves %>%
    select(dataset, z, curve_sign, curve_replication) %>%
    pivot_longer(
      cols = c(curve_sign, curve_replication),
      names_to = "metric",
      values_to = "prob"
    ) %>%
    mutate(
      metric = recode(
        metric,
        curve_sign = "Correct sign",
        curve_replication = "Exact replication"
      )
    )

  median_df <- curve_df %>%
    group_by(metric, z) %>%
    summarise(prob = median(prob), .groups = "drop")

  ggplot(curve_df, aes(x = z, y = prob, group = interaction(dataset, metric))) +
    geom_vline(xintercept = 1.96, color = slide_cols$grey, linetype = "22", linewidth = 0.8) +
    geom_line(
      aes(color = metric),
      linewidth = 1.0,
      alpha = 0.28,
      show.legend = FALSE
    ) +
    geom_line(
      data = median_df,
      aes(color = metric, group = metric),
      linewidth = 2.8,
      show.legend = FALSE
    ) +
    annotate(
      "label",
      x = 4.3,
      y = 0.965,
      label = "Correct sign",
      fill = alpha("white", 0.85),
      color = slide_cols$blue,
      linewidth = 0,
      size = 4.8
    ) +
    annotate(
      "label",
      x = 4.12,
      y = 0.56,
      label = "Exact replication",
      fill = alpha("white", 0.85),
      color = slide_cols$rust,
      linewidth = 0,
      size = 4.8
    ) +
    scale_color_manual(
      values = c(
        "Correct sign" = slide_cols$blue,
        "Exact replication" = slide_cols$rust
      )
    ) +
    scale_x_continuous(
      breaks = c(0, 1, 1.96, 3, 4, 5),
      labels = c("0", "1", "1.96", "3", "4", "5"),
      limits = c(0, 5)
    ) +
    scale_y_continuous(
      breaks = seq(0, 1, by = 0.2),
      limits = c(0, 1),
      labels = number_format(accuracy = 0.1)
    ) +
    labs(x = "|z|", y = "Probability") +
    theme_bear_slide(base_size = 18) +
    theme(
      axis.title = element_text(size = 13.5),
      axis.text = element_text(size = 11.5)
    )
}
