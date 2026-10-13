# Talks

Presentation sources and final PDFs, with scripts, themes and required local
inputs. Each talk has a PDF that can be read without rendering the source.

## Current contents

| Folder | Source | PDF | Summary |
|---|---|---|---|
| `2020 08 baggr stancon/` | [Source](2020%2008%20baggr%20stancon/baggr_stancon_2020.Rmd) | [PDF](2020%2008%20baggr%20stancon/baggr_stancon_2020.pdf) | StanCon 2020: Bayesian meta-analysis in Stan with `baggr`. |
| `2021 general meta analysis slides/` | [Source](2021%20general%20meta%20analysis%20slides/meta-analysis%20slides.pptx) | [PDF](2021%20general%20meta%20analysis%20slides/2021-meta-analysis.pdf) | General introduction to meta-analysis; PowerPoint source. |
| `2022 12 baggr paris/` | [Source](2022%2012%20baggr%20paris/baggr_paris_2022.Rmd) | [PDF](2022%2012%20baggr%20paris/baggr_paris_2022.pdf) | December 2022: Bayesian meta-analysis in Stan with `baggr`. |
| `2023 00 baggr esmarconf/` | [Source](2023%2000%20baggr%20esmarconf/baggr_esmarconf_2023.Rmd) | [PDF](2023%2000%20baggr%20esmarconf/baggr_esmarconf_2023.pdf) | ESMARConf 2023: Bayesian meta-analysis with `baggr`; month unrecorded. |
| `2023 04 meta analysis mini course/` | [Source](2023%2004%20meta%20analysis%20mini%20course/2023-04-meta-analysis.Rmd) | [PDF](2023%2004%20meta%20analysis%20mini%20course/2023-04-meta-analysis.pdf) | April 2023 mini-course introducing meta-analysis. |
| `2023 06 network meta analysis mini course/` | [Source](2023%2006%20network%20meta%20analysis%20mini%20course/2023-06-network-meta-analysis.Rmd) | [PDF](2023%2006%20network%20meta%20analysis%20mini%20course/2023-06-network-meta-analysis.pdf) | June 2023 mini-course on network meta-analysis. |
| `2025 03 meta analysis single study/` | [Source](2025%2003%20meta%20analysis%20single%20study/2025%2002%20meta%20analysis%20single%20study.Rmd) | [PDF](2025%2003%20meta%20analysis%20single%20study/2025-03-meta-analysis-single-study.pdf) | March 2025: meta-analysis with a single study; source retains its original February filename. |
| `2026 02 fca meta analysis workshop/` | [Source](2026%2002%20fca%20meta%20analysis%20workshop/meta-analysis_intro.Rmd) | [PDF](2026%2002%20fca%20meta%20analysis%20workshop/meta-analysis_intro.pdf) | February 2026 FCA workshop, with R examples, Stan models and teaching data. |
| `2026 03 cgd replications/` | [Source](2026%2003%20cgd%20replications/cgd_replications_mar2026_modern.Rmd) | [PDF](2026%2003%20cgd%20replications/2026-03-cgd-gold-standard-science.pdf) | March 2026 CGD: gold standard science and replication. |
| `2026 09 uchicago agents/` | [Source](2026%2009%20uchicago%20agents/agents.Rmd) | [PDF](2026%2009%20uchicago%20agents/2026-09-uchicago-ai-agents.pdf) | September 2026 University of Chicago: working with AI agents. |
| `2026 09 uchicago replications/` | [Source](2026%2009%20uchicago%20replications/optimism.Rmd) | [PDF](2026%2009%20uchicago%20replications/2026-09-uchicago-scientific-optimism.pdf) | September 2026 University of Chicago: a statistical case for qualified scientific optimism. |

## Rendering and repository contents

Most decks use R Markdown and Beamer; rendering requires R, the packages
used by the source, Pandoc and a LaTeX installation. Older sources were moved
from other projects and may still require their original data or working
folder. The PDFs are the saved presentation versions.

- CGD: from this repository root, run
  `Rscript "2026 03 cgd replications/scripts/render_modern.R"`.
  Its local inputs are committed as compressed RDS files, alongside the
  image assets used by the source. See the talk's README for figure commands.
- Chicago AI agents: from `2026 09 uchicago agents/`, run
  `Rscript --vanilla render.R`.
- Chicago scientific optimism: from `2026 09 uchicago replications/`, run
  `Rscript --vanilla render.R`. This requires a sibling `BEAR` checkout
  containing the data and saved fits listed in that talk's README.
- Single-study deck: from `2025 03 meta analysis single study/`, render with
  `rmarkdown::render("2025 02 meta analysis single study.Rmd", output_file = "2025-03-meta-analysis-single-study.pdf")`
  to retain the published PDF filename.

The ignore rules exclude R Markdown caches, LaTeX intermediates, editor and
session state, compiled Stan models, saved workshop fits, obsolete local
archives and the duplicate CGD deck in the Chicago folder. Chicago figures
and summaries are regenerated from BEAR. Local ignored files are retained
on disk; final talk PDFs and figure assets needed by the CGD source are tracked.
