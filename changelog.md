# Changelog

## 2026-10-13

- Prepared the standalone talks repository for GitHub: retained sources,
  required inputs and one final PDF per talk; ignored caches, intermediates,
  local archives and duplicate decks.
- Added the Chicago AI-agents talk to the index, linked each PDF, and corrected
  the moved CGD workflow paths and documentation.
- Gave ambiguous PDF names a date and topic; retained existing source names.
- Losslessly compressed the CGD RDS inputs and checked object equality in R.

## 2026-05-06

- Added `2026 02 fca meta analysis workshop/` to `README.md` after it was
  added to `talks/`.
- Removed the candidate shortlist from `README.md`; the other scanned
  materials are not being tracked as relevant talk candidates.
- Created `talks/` to collect root-level presentation materials.
- Moved likely talk decks, rendered outputs, generated figure/cache folders,
  pasted images used by the single-study deck, and loose demo scripts into
  topic-specific subfolders.
- Left relative paths inside moved Rmd files and scripts unchanged.
- Added `README.md` with one-line talk summaries and notes on which talk-like
  files were already committed in Git.
- Renamed talk folders to the preferred `year month title` convention where
  dates are known, using `undated` for materials without a local date.
