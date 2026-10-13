# Alternative six-panel figure with a bimodal absolute-effect distribution:
# most effects are small, but a substantial minority cluster around a large
# effect value, producing a visible bump in |effect|.

library(tidyverse)
library(patchwork)
library(scales)

# Setup -----
set.seed(20260323)

sig_thresh <- 1.96
n_draws <- 120000
power_target <- 0.80

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
                            overlay = NULL, threshold = NULL,
                            note = NULL) {
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
    {
      if (!is.null(note)) {
        annotate(
          "text",
          x = xlim[2] - 0.03 * diff(xlim),
          y = ymax * 0.95,
          label = note,
          hjust = 1,
          vjust = 1,
          size = 3.6,
          color = "grey30"
        )
      }
    } +
    coord_cartesian(xlim = xlim, ylim = c(0, ymax), expand = FALSE) +
    labs(title = title, x = x_lab, y = NULL) +
    panel_theme
}

snr_to_power <- function(snr, sig_thresh) {
  pnorm(-sig_thresh, snr, 1) + 1 - pnorm(sig_thresh, snr, 1)
}

target_snr_for_power <- function(power_target, sig_thresh) {
  uniroot(
    function(snr) snr_to_power(snr, sig_thresh) - power_target,
    interval = c(0, 10)
  )$root
}

# Alternative illustrative simulation -----
# The strong-effect share is calibrated to keep a visible hump near the
# 80%-power target SNR in the overall |z| distribution without letting the
# strong-effect component dominate the mixture too heavily.
big_weight <- 0.60
big_mean <- 0.95
big_sd <- 0.06

is_big <- runif(n_draws) < big_weight
effect_abs <- numeric(n_draws)
effect_abs[!is_big] <- rgamma(sum(!is_big), shape = 1.6, scale = 0.07)
effect_abs[is_big] <- pmax(rnorm(sum(is_big), mean = big_mean, sd = big_sd), 0.02)

effect_signed <- effect_abs * sample(c(-1, 1), n_draws, replace = TRUE)
target_snr <- target_snr_for_power(power_target, sig_thresh)
design_effect <- if_else(is_big, effect_abs, 1)
se_draw <- design_effect / target_snr

snr <- effect_signed / se_draw
power <- snr_to_power(snr, sig_thresh)
z_raw <- snr + rnorm(n_draws)

z_manip <- z_raw
eligible <- which(z_raw > 0 & z_raw < sig_thresh)
n_manip <- round(manip_share * length(eligible))
manip_idx <- sample(eligible, size = n_manip)
z_manip[manip_idx] <- 1.98 + 0.62 * rbeta(n_manip, shape1 = 3.5, shape2 = 8)

keep_prob <- ifelse(abs(z_manip) >= sig_thresh, keep_sig, keep_nonsig)
keep_draw <- runif(n_draws) < keep_prob
z_pub <- z_manip[keep_draw]

n_nonsig_raw <- sum(abs(z_raw) < sig_thresh)
n_nonsig_manip <- sum(abs(z_manip) < sig_thresh)
hacked_share_nonsig <- n_manip / n_nonsig_raw
omitted_nonsig_share <- 1 - mean(keep_draw[abs(z_manip) < sig_thresh])

sim_summary <- tibble(
  target_snr = target_snr,
  big_weight = big_weight,
  effect_q50 = quantile(effect_abs, 0.5),
  effect_q90 = quantile(effect_abs, 0.9),
  planned_se_weak = unique(se_draw[!is_big]),
  planned_se_strong_q50 = quantile(se_draw[is_big], 0.5),
  power_weak_q50 = quantile(power[!is_big], 0.5),
  power_strong_q50 = quantile(power[is_big], 0.5),
  hacked_share_nonsig = hacked_share_nonsig,
  omitted_nonsig_share = omitted_nonsig_share,
  n_nonsig_raw = n_nonsig_raw,
  n_nonsig_post_hack = n_nonsig_manip,
  power_below_0_1 = mean(power < 0.1),
  power_above_0_9 = mean(power > 0.9),
  signif_raw = mean(abs(z_raw) >= sig_thresh)
)

print(sim_summary)

# Plot panels -----
effect_breaks <- seq(0, 1.6, by = 0.05)
se_breaks <- seq(0.20, 0.45, by = 0.005)
z_breaks <- seq(0, 8, by = 0.25)

p1 <- plot_hist_panel(
  effect_abs,
  title = "1. Draw |effect|",
  x_lab = "|Effect size|",
  fill_key = "effect",
  breaks = effect_breaks
)

p2 <- plot_hist_panel(
  se_draw,
  title = "2. Design study (fix SE)",
  x_lab = "Planned SE",
  fill_key = "power",
  breaks = se_breaks
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
  threshold = sig_thresh,
  note = sprintf("%.1f%% of p > 0.05 hacked", 100 * hacked_share_nonsig)
)

p6 <- plot_hist_panel(
  abs(z_pub),
  title = "6. Publish selectively",
  x_lab = "Published |z|",
  fill_key = "pub",
  breaks = z_breaks,
  overlay = abs(z_manip),
  threshold = sig_thresh,
  note = sprintf("%.1f%% of p > 0.05 omitted", 100 * omitted_nonsig_share)
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

pdf_file <- file.path(out_dir, "production_function_bimodal_effects.pdf")
png_file <- file.path(out_dir, "production_function_bimodal_effects_slide.png")

ggsave(pdf_file, full_plot, width = 12, height = 6.75, units = "in")
ggsave(
  png_file,
  full_plot,
  width = 12,
  height = 6.75,
  units = "in",
  dpi = 320
)
