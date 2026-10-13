# Illustrative six-panel figure showing a stylized production function of
# empirical research, from latent effect sizes to publication-biased |z|.
# Uses a Cochrane-inspired but more optimistic mixture to balance the power plot.

library(tidyverse)
library(patchwork)
library(scales)

# Setup -----
set.seed(20260323)

sig_thresh <- 1.96
n_draws <- 120000

manip_share <- 0.16
keep_nonsig <- 0.28
keep_sig <- 0.98

out_dir <- file.path(
  "2026 03 cgd replications", "production_function", "figures"
)
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

fill_cols <- c(
  effect = "#0F766E",
  power = "#C2410C",
  snr = "#2563EB",
  z = "#B91C1C",
  manip = "#D97706",
  pub = "#111827"
)

line_cols <- c(
  effect = "#115E59",
  power = "#9A3412",
  snr = "#1D4ED8",
  z = "#991B1B",
  manip = "#B45309",
  pub = "#111827"
)

panel_theme <- theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_line(color = "grey84", linewidth = 0.3),
    axis.title = element_text(size = 12.5, color = "grey20"),
    axis.text = element_text(size = 11.5, color = "grey25"),
    plot.title = element_text(face = "bold", size = 14.5),
    plot.caption = element_text(size = 10, color = "grey35"),
    plot.margin = margin(4, 5, 4, 5)
  )

make_hist_stats <- function(x, breaks) {
  x <- x[x >= min(breaks) & x <= max(breaks)]
  h <- hist(x, breaks = breaks, plot = FALSE, include.lowest = TRUE)
  step_df <- tibble(
    x = h$breaks,
    y = c(h$density, tail(h$density, 1))
  )
  list(hist = h, step_df = step_df, ymax = max(h$density))
}

plot_hist_panel <- function(x, title, x_lab, fill_key, breaks,
                            overlay = NULL, threshold = NULL) {
  stats <- make_hist_stats(x, breaks)
  ymax <- stats$ymax

  if (!is.null(overlay)) {
    overlay_stats <- make_hist_stats(overlay, breaks)
    ymax <- max(ymax, overlay_stats$ymax)
  }

  ymax <- ymax * 1.34
  xlim <- range(breaks)

  p <- ggplot(tibble(x = x), aes(x = x)) +
    geom_histogram(
      aes(y = after_stat(density)),
      breaks = breaks,
      fill = alpha(fill_cols[[fill_key]], 0.24),
      color = NA
    )

  if (!is.null(overlay)) {
    p <- p +
      geom_step(
        data = overlay_stats$step_df,
        aes(x = x, y = y),
        inherit.aes = FALSE,
        color = "grey55",
        linewidth = 0.75,
        linetype = "22",
        direction = "hv"
      )
  }

  p +
    geom_step(
      data = stats$step_df,
      aes(x = x, y = y),
      inherit.aes = FALSE,
      color = line_cols[[fill_key]],
      linewidth = 0.95,
      direction = "hv"
    ) +
    {
      if (!is.null(threshold)) {
        geom_vline(
          xintercept = threshold,
          linewidth = 0.7,
          color = "grey35",
          linetype = "31"
        )
      }
    } +
    coord_cartesian(xlim = xlim, ylim = c(0, ymax), expand = FALSE) +
    labs(title = title, x = x_lab, y = NULL) +
    panel_theme
}

# Illustrative simulation -----
# These weights are loosely inspired by fitted Cochrane-like mixtures, but are
# reweighted to produce a more balanced tub-shaped power distribution.
p_mix <- c(0.20, 0.35, 0.30, 0.15)
snr_sigma <- c(0.4, 2.2, 4.8, 9.5)

se_median <- 0.10
se_sdlog <- 0.20
effect_sigma <- snr_sigma * se_median

comp_id <- sample(seq_along(p_mix), n_draws, replace = TRUE, prob = p_mix)
effect_signed <- rnorm(n_draws, mean = 0, sd = effect_sigma[comp_id])
se_draw <- rlnorm(n_draws, meanlog = log(se_median), sdlog = se_sdlog)

snr <- effect_signed / se_draw
power <- pnorm(-sig_thresh, snr, 1) + 1 - pnorm(sig_thresh, snr, 1)
z_raw <- snr + rnorm(n_draws)

z_manip <- z_raw
eligible <- which(z_raw > 0 & z_raw < sig_thresh)
n_manip <- round(manip_share * length(eligible))
manip_idx <- sample(eligible, size = n_manip)
z_manip[manip_idx] <- 1.98 + 0.62 * rbeta(n_manip, shape1 = 3.5, shape2 = 8)

keep_prob <- ifelse(abs(z_manip) >= sig_thresh, keep_sig, keep_nonsig)
keep_draw <- runif(n_draws) < keep_prob
z_pub <- z_manip[keep_draw]

sim_summary <- tibble(
  power_below_0_1 = mean(power < 0.1),
  power_above_0_9 = mean(power > 0.9),
  signif_raw = mean(abs(z_raw) >= sig_thresh),
  manipulated_share = n_manip / length(eligible),
  kept_below_1_96 = mean(keep_draw[abs(z_manip) < sig_thresh]),
  kept_above_1_96 = mean(keep_draw[abs(z_manip) >= sig_thresh])
)

print(sim_summary)

# Plot panels -----
effect_breaks <- seq(0, 1.6, by = 0.05)
power_breaks <- seq(0, 1, by = 0.025)
z_breaks <- seq(0, 8, by = 0.25)

p1 <- plot_hist_panel(
  abs(effect_signed),
  title = "1. Draw |effect|",
  x_lab = "|Effect size|",
  fill_key = "effect",
  breaks = effect_breaks
)

p2 <- plot_hist_panel(
  power,
  title = "2. Set power (fix SE)",
  x_lab = "Power",
  fill_key = "power",
  breaks = power_breaks
)

p3 <- plot_hist_panel(
  abs(snr),
  title = "3. |SNR| = |true effect|/SE",
  x_lab = "|SNR|",
  fill_key = "snr",
  breaks = z_breaks
)

p4 <- plot_hist_panel(
  abs(z_raw),
  title = "4. Run experiment: SNR + N(0,1)",
  x_lab = "|z|",
  fill_key = "z",
  breaks = z_breaks,
  threshold = sig_thresh
)

p5 <- plot_hist_panel(
  abs(z_manip),
  title = "5. p-hack some values < 0.05",
  x_lab = "|z| after nudging",
  fill_key = "manip",
  breaks = z_breaks,
  overlay = abs(z_raw),
  threshold = sig_thresh
)

p6 <- plot_hist_panel(
  abs(z_pub),
  title = "6. Publish selectively",
  x_lab = "Published |z|",
  fill_key = "pub",
  breaks = z_breaks,
  overlay = abs(z_manip),
  threshold = sig_thresh
)

full_plot <- (p1 + p2 + p3) / (p4 + p5 + p6) +
  plot_annotation(
    caption = paste(
      "illustrative distributions only, but with shapes based on BEAR datasets"
    )
  ) &
  theme(
    plot.caption = element_text(size = 9, color = "grey35")
  )

pdf_file <- file.path(out_dir, "production_function_cochrane.pdf")
png_file <- file.path(out_dir, "production_function_cochrane_slide.png")

ggsave(pdf_file, full_plot, width = 12, height = 6.75, units = "in")
ggsave(
  png_file,
  full_plot,
  width = 12,
  height = 6.75,
  units = "in",
  dpi = 320
)
