# Replications / BEAR / Qualified Scientific Optimism
## Working slide outline — paper section only

General principle:
- Present this as a fairly conventional academic seminar.
- Two explicit contributions:
  1. BEAR as a data/infrastructure contribution.
  2. A statistical model for the distribution of SNRs and what it implies about
     power, sign errors, and replication.
- Reuse material from the CGD deck wherever possible.
- Follow the paper much more closely once we reach the model and results.
- Do not yet write much new prose. Most eventual slide text should come from the
  existing CGD slides or manuscript, shortened for presentation.
- Model section: maximum ~10 minutes.
- Replication programmes / Gold Standard Science comes later, after the paper
  presentation, and is not specified here yet.


# INTRODUCTION

## Slide 1 — Title
SOURCE: PAPER
STATUS: REUSE / MINIMAL ADAPTATION

- "A Statistical Case for (Qualified) Scientific Optimism"
- Authors: Witold Więcek, Erik van Zwet, Andrew Gelman.
- Normal academic seminar title slide.
- Do not open with Gold Standard Science.


## Slide 2 — The conventional binary model of scientific findings
SOURCE: PAPER §1.1
STATUS: NEW SLIDE, BUT ALMOST ENTIRELY BASED ON PAPER

Purpose:
- Introduce the conventional 2 × 2 view before criticising it.
- Base this closely on "Going beyond the characterization of scientific claims
  as true or false".
- Explain the model in its own terms:
    - "no relationship" versus "true relationship";
    - significant versus non-significant result;
    - low PoS under a null and substantially higher PoS under a real effect;
    - significance therefore appears able to separate the two groups.
- Mention Ioannidis as the canonical example.
- We do not need a long replication-crisis motivation before this.


## Slide 3 — Why the 2 × 2 model is a poor description of empirical research
SOURCE: PAPER §1.1
STATUS: NEW / CONDENSE PAPER

Purpose:
- Present the two criticisms from the manuscript.

Structure:
1. Scientific questions generally do not reduce naturally to "exactly zero"
   versus "non-zero".
2. The implied distribution of SNR / PoS is unrealistic:
   - null studies have SNR = 0 / PoS = 0.05;
   - "true" studies are effectively imagined as having some much larger fixed
     SNR / PoS;
   - in reality researchers do not know the true effect when designing studies.

This slide should set up why we want to estimate a continuous distribution of
SNRs rather than classify studies into two latent types.


## Slide 4 — Contributions
SOURCE: PAPER INTRODUCTION
STATUS: STANDARD SEMINAR SLIDE; CLOSELY PARAPHRASE PAPER

Two contributions only:

1. DATA:
   Benchmarks of Empirical Accuracy in Research (BEAR)
   - large harmonised database built from existing public corpora;
   - processed into a form suitable for metascientific analysis;
   - open source / reusable.

2. METHOD:
   Extend the existing model of empirical z-statistics / SNRs to accommodate
   selective reporting and truncation, then derive quantities such as:
   - probability of significance;
   - probability of correct sign;
   - probability of successful replication.

Possible one-line preview of substantive conclusion at bottom, but keep this
secondary.


# PART I — DATA / BEAR

## Slide 5 — BEAR as a data contribution
SOURCE: PAPER DATA SECTION + CURRENT BEAR
STATUS: REWRITE OLD CGD "BEAR" SLIDE IN MORE ACADEMIC STYLE

Purpose:
- Describe BEAR as research infrastructure rather than as a general-interest
  pitch.

Include:
- what BEAR aggregates;
- unit(s) of data;
- effect estimates / standard errors / z-values / study identifiers / metadata;
- number of datasets/corpora in current BEAR;
- number of studies / estimates;
- breadth of fields;
- important statement that BEAR does not collect new primary data: it
  standardises existing datasets.

IMPORTANT:
- Use current repository numbers when slides are actually built.
- Do not reuse stale March 2026 counts from CGD.


## Slide 6 — Accessing BEAR
SOURCE: BEAR WEBSITE / REPOSITORY
STATUS: NEW

Purpose:
- Explicitly advertise that the data are downloadable and reusable.

Include eventually:
- BEAR website URL;
- GitHub / data download location;
- very short note on format/documentation/licensing as appropriate.
- Leave room for a screenshot of the BEAR website later.

ACTION FOR BUILD STAGE:
- Visit current BEAR website and repository.
- Use current download instructions rather than inventing them.


## Slide 7 — What does one observation look like?
SOURCE: CURRENT BEAR DATA
STATUS: NEW, GENERATED IN R

Purpose:
- Make the data structure tangible.

Content:
- Show a small number of real rows sampled from BEAR.
- Choose useful columns only, probably something like:
    corpus / study ID / estimate type / estimate / SE / z / p-value /
    relevant metadata.
- Need to distinguish clearly between:
    study
    estimate/result within study
- Mention that some corpora contribute one/few estimates per study and others
  contribute many.

ACTION:
- Generate table directly from BEAR in R.
- Pick rows that demonstrate heterogeneity without making the table messy.


## Slide 8 — Corpora used in this paper
SOURCE: PAPER TABLE 1 / REPOSITORY TABLE
STATUS: UPDATE CGD TABLE

Purpose:
- Reuse the very successful CGD table format.
- Same approximate visual density as old CGD slide.
- Replace old 11-corpus contents with the current paper table.

Likely columns:
- Dataset
- Domain
- Number of studies
- Mean estimates per study / equivalent
- Percentage significant
(or whatever exact columns are in current paper Table 1)

ACTION:
- Pull current table directly from repository.
- Do not manually transcribe values if avoidable.


## Slide 9 — Example distribution: Cochrane
SOURCE: CGD + PAPER FIGURES
STATUS: REUSE CGD STRUCTURE, UPDATE DATA

Purpose:
- First look at the empirical |z| distribution without imposing the model.

Content:
- Cochrane histogram only.
- No fitted density yet.
- Point out basic visual features only.
- This should look very much like the corresponding CGD slide.


## Slide 10 — |z| distributions across other corpora
SOURCE: PAPER FIGURE / EXISTING BEAR PLOTTING CODE
STATUS: ADAPT PAPER FIGURE

Purpose:
- Establish that the Cochrane pattern is not unique.

Content:
- Select ~8–10 corpora from the paper.
- Histograms only.
- No fitted or corrected densities yet.
- Render using the same plotting style/code as the paper.
- Annotation/note:
  the paper contains the full set; only a subset is shown here so panels remain
  readable.

This concludes the DATA section.


# PART II — STATISTICAL MODEL
# Target: no more than ~10 minutes total.

## Slide 11 — z-values and signal-to-noise ratios
SOURCE: CGD SLIDE + PAPER MODEL SECTION
STATUS: REUSE CGD ALMOST VERBATIM

Core definitions:

    z_i = beta_hat_i / SE(beta_hat_i)

    SNR_i = beta_i / SE(beta_hat_i)

Under unbiased approximately normal estimation:

    z_i = SNR_i + epsilon_i
    epsilon_i ~ N(0,1)

Purpose:
- Make the distinction between realised z and latent SNR completely explicit.
- Retain the useful mapping between common p-value thresholds and |z| if space
  permits.


## Slide 12 — From latent SNRs to observed z-values
SOURCE: PAPER + POSSIBLY EXISTING REPOSITORY FIGURE
STATUS: NEW / VISUAL PLACEHOLDER

Purpose:
- Give an intuitive bridge before introducing the mixture model.

Concept:

    latent distribution of SNR
            +
        N(0,1) sampling noise
            ↓
    observed distribution of z

Potential design:
- Mostly a figure rather than prose.
- Look in repository first for an existing suitable plot.
- If none exists, create a simple explanatory figure.

Also introduce the probability of significance:

    PoS(SNR)
      = Pr(|z| >= 1.96 | SNR)

Use paper equation (1).

Explicit example:
- if SNR = ±2.8, PoS ≈ 80%.

Possibly include the paper's example illustrating how variable z can remain even
when true power is 80%, if it fits cleanly.


## Slide 13 — Model for the observed z distribution
SOURCE: PAPER MODEL SECTION
STATUS: NEW ACADEMIC SLIDE; USE PAPER EQUATION

Purpose:
- Say explicitly:
  first model the observed distribution of z;
  then infer the latent distribution of SNR.

Introduce the mixture:

    f(z | p, sigma)
      = sum_i p_i (1/sigma_i) phi(z / sigma_i)

Key explanation:
- signed z-values are represented as a mixture of zero-mean normals;
- equivalently, |z| follows a mixture of half-normal distributions;
- sigma_i >= 1 because every z contains unit-variance sampling noise;
- paper uses k = 4.

Do not over-explain estimation details yet.


## Slide 14 — Deconvolution: recovering the SNR distribution
SOURCE: PAPER
STATUS: NEW; VERY CLOSE TO PAPER

Purpose:
- Show why the model makes inference about SNR especially simple.

Given:

    z = SNR + epsilon
    epsilon ~ N(0,1)

For each mixture component, subtract the sampling variance:

    f_SNR(x | p, sigma)
      = f(x | p, sqrt(sigma^2 - 1))

Main conceptual sentence:
- The observed cross-study z distribution is a convolution of the latent SNR
  distribution and N(0,1) sampling noise.

This slide should be mathematically clean and quite sparse.


## Slide 15 — Adjustment for selective reporting
SOURCE: PAPER
STATUS: NEW / PAPER EQUATIONS

Purpose:
- Introduce the Hedges-style selection model used as an adjustment.

Define:

    omega =
      Pr(observed | |z| < 1.96)
      --------------------------------
      Pr(observed | |z| >= 1.96)

Then show the corresponding piecewise reweighting of the density if it fits.

Main message:
- allow observations below the conventional threshold to have a lower
  probability of appearing in the corpus;
- omega is part of the model needed to recover the underlying z distribution.

IMPORTANT:
- Do not yet interpret omega as a definitive measurement of publication bias.
- That caveat belongs especially in the results section.


## Slide 16 — Truncation, repeated estimates, and likelihood
SOURCE: PAPER
STATUS: NEW / COMPACT METHODS SLIDE

Purpose:
- Finish the model specification without drowning audience in the full
  censoring likelihood.

Include:
- reported statements such as p < .05, p < .01, p < .001 are treated as
  censored/truncated observations rather than exact z-values;
- observations are weighted by the inverse number of z-values contributed by a
  study;
- model is fitted by weighted maximum likelihood.

Can show:

    ell(p, sigma, omega)
      = sum_j w_j log f(z_tilde_j, delta_j | p, sigma, omega, published)

Do NOT put the full six-case censoring likelihood on the main slide.
Move full details to backup if wanted.


## Slide 17 — Quantities implied by the estimated SNR distribution
SOURCE: PAPER
STATUS: ADAPT CGD "WHAT WE ESTIMATE" + ADD FORMULAS

Purpose:
- Close the model section by connecting it to substantive questions.

Derive / define:

1. Probability of significance / power:
       PoS(SNR)

2. Probability that the observed estimate has the correct sign:
       Pr(z * SNR > 0 | |z|)

3. Probability of "successful replication":
       Pr(z_repl * z > 0 and |z_repl| > 1.96 | |z|)

Explain:
- some quantities can be averaged over a whole corpus;
- others can be conditioned on the observed |z|.

Make explicit that a replication is imagined to have the same underlying SNR
and independent N(0,1) sampling noise.


## Slide 18 — Conditional inference for SNR given z
SOURCE: PAPER APPENDIX
STATUS: PROBABLY BACKUP; POSSIBLY MAIN IF TIME ALLOWS

Purpose:
- Useful technical reminder for an academic audience.
- Show that the fitted marginal model plus z | SNR determines SNR | z.

Could include:
- posterior/conditional component weights q_i(z);
- conditional means mu_i(z);
- conditional variances tau_i^2;
- from this, derive correct-sign and replication probabilities.

DECISION LATER:
- likely backup if model section is running over 10 minutes;
- main slide if audience is particularly statistical.


# PART III — RESULTS

## Slide 19 — Model fit across corpora
SOURCE: PAPER FIGURE + SAME CORPORA AS SLIDE 10
STATUS: ADAPT EXISTING PAPER CODE

Purpose:
- Return to the exact histograms shown earlier.
- Now overlay fitted densities.

Content:
- same ~8–10 selected corpora as Slide 10;
- observed histogram;
- fitted density conditional on reporting;
- corrected / unconditional density if useful and visually legible.

Main annotation:
- simple mixtures plus a simple selection mechanism approximate these very
  heterogeneous empirical corpora reasonably well.


## Slide 20 — A striking empirical regularity: decreasing |z| distributions
SOURCE: PAPER RESULTS / DISCUSSION
STATUS: NEW SLIDE USING EXISTING FIGURES

Purpose:
- Emphasise this more strongly than the CGD presentation did.

Main observations:
- mixture-of-half-normal densities are mathematically decreasing;
- importantly, the empirical histograms themselves broadly have this feature;
- low absolute z / low SNR studies are much more common than very high-SNR
  studies;
- across research areas the major differences are largely:
    1. width of the distribution;
    2. degree of selection/reporting.

Could reuse panels from Slide 19 or use selected subset figures.

Possible additional robustness:
- Cochrane specialties / clinical-trial phases if useful.
- Decide during build whether this deserves an extra slide.


## Slide 21 — What does the selection parameter tell us?
SOURCE: PAPER RESULTS
STATUS: NEW / CLOSELY FOLLOW PAPER TEXT

Purpose:
- Discuss the very large heterogeneity in estimated selection,
  while explicitly warning against overinterpretation.

Structure:
- Show estimated omega across corpora, probably as a compact table or plot.
- Draw attention to the range:
    strong apparent selection in some text-mined / representative corpora;
    relatively little in curated corpora such as Cochrane.
- Pull exact values from current Table 2. DO NOT rely on remembered numbers.

Crucial caveat from paper:
- many studies report multiple outcomes;
- we generally do not know which result affected publication/reporting;
- the one-parameter Hedges model is intentionally simple;
- omega is primarily used to adjust the inferred distribution, not as our
  definitive cross-field measure of "publication bias".

This slide should echo the paper's wording closely.


## Slide 22 — Distribution of probability of significance / power
SOURCE: PAPER FIGURE `pos_gap`, LEFT PANEL
STATUS: REUSE PAPER FIGURE

Purpose:
- Move from the fitted SNR distributions to quantities researchers care about.

Show:
- left panel of `pos_gap`;
- survival curves for PoS.

Comment on:
- average assurance / corpus-level probability of significance;
- proportion of studies whose true PoS reaches 80%;
- heterogeneity across corpora.

Use exact current-paper ranges from tables, not old CGD numbers.

Important interpretation:
- low realised PoS does not necessarily mean researchers performed an
  irrational sample-size calculation;
- researchers do not know the true effect when choosing sample size.


## Slide 23 — Correct sign versus successful replication
SOURCE: PAPER FIGURE `pos_gap`, RIGHT PANEL
STATUS: REUSE PAPER FIGURE; CENTRAL RESULTS SLIDE

Purpose:
- This is probably the most important substantive slide.

Show:
- probability of correct sign conditional on |z|;
- probability of a statistically significant replication in the same direction
  conditional on |z|.

Emphasise:
- the two probabilities are very different;
- correct-sign probability is much higher than replication probability across
  the corpora.

Use the |z| = 1.96 comparison explicitly:
- pull exact current ranges from the paper/table;
- current manuscript has roughly:
    replication 27–44%;
    correct sign 82–97%.
- verify before building.


## Slide 24 — A marginally significant result can be less replicable than an average study
SOURCE: PAPER RESULTS, ESPECIALLY DISCUSSION AROUND TABLE 2
STATUS: NEW / VERY CLOSE PARAPHRASE OF PAPER

Purpose:
- Explain the counterintuitive feature correctly.

DO NOT state simply:
  "significance does not imply replication."

Instead make the paper's more precise point:

- If |z| = 1.96, the conditional probability of successful replication can be
  only modest and can even be below the unconditional replication probability
  for a randomly selected study in that corpus.
- Observing a result right at the significance threshold is weak evidence about
  a high underlying SNR.
- This is not just a consequence of "many low-powered studies".
- If the entire corpus had higher SNRs, a realised z exactly around 1.96 could
  actually be even more negatively informative about the study's latent SNR.

SOURCE TEXT TO USE WHEN WRITING:
- Pull wording and argument directly from the paragraph in the Results section
  discussing |z| = 1.96 and successful replication.
- Be careful not to replace it with a generic regression-to-the-mean argument.


## Slide 25 — Results summary
SOURCE: PAPER RESULTS / DISCUSSION
STATUS: NEW, BUT ONLY SUMMARISE WHAT HAS JUST BEEN SHOWN

Potential structure:
1. Across corpora, |z| distributions are broadly decreasing.
2. Research areas mainly differ in distribution width and degree of selection.
3. Most studies have modest true PoS; relatively few achieve 80% PoS.
4. A significant result can still have a modest probability of a significant
   same-direction replication.
5. The same result can nevertheless have a high probability of getting the
   direction of the effect right.

Keep this descriptive.
Do not yet return to the 2 × 2 model here.
Do not yet make the broader replication-policy argument.


# PART IV — DISCUSSION
# Keep short. These are synthesis slides, not another long argument.

## Slide 26 — Four features that hold across the empirical corpora
SOURCE: PAPER DISCUSSION, "What our meta-analysis says about effect sizes and replication rates"
STATUS: CLOSELY CONDENSE PAPER

Purpose:
- Give the audience the paper's four main empirical findings in one place.
- This should be a clean summary slide rather than adding interpretation.

Structure:

1. Absolute z-values have broadly decreasing distributions.
   - Correspondingly, low absolute SNRs are more common than high SNRs.
   - Research areas differ substantially in the width of these distributions.

2. Probability of significance is generally modest.
   - Only a minority of studies have true PoS / power of 80% or more.

3. Statistical significance does not imply a high probability of successful replication.
   - Even quite small p-values can leave substantial replication uncertainty.

4. Statistical significance does imply a high probability that the direction of the effect is correct.

Keep close to the exact language of the paper.
Could perhaps visually emphasise points 3 and 4 as the central contrast.


## Slide 27 — Interpretation
SOURCE: PAPER INTRODUCTION + DISCUSSION
STATUS: NEW SYNTHESIS, DRAWN FROM EXISTING PAPER ARGUMENTS

Purpose:
- One short interpretive slide before moving to the broader metascience take.
- Restate what the results mean without introducing another substantive section.

Possible content:

- The binary "null versus true effect" model is a poor description of the empirical distributions we observe.
  - SNR / power varies continuously rather than separating into two clean classes.

- Low rates of statistically significant replication are therefore not, by themselves,
  evidence that most published findings are false.

- The same empirical literature can simultaneously have:
    - modest average power;
    - low probability of significance twice in succession;
    - fairly high probability of getting the direction of an effect right.

- Why might broadly similar shapes appear across very different fields?
  - A tentative "anthropic" explanation from the paper:
    researchers choose questions and sample sizes under constraints of cost, time,
    logistics, uncertain effects, and incentives to obtain informative/significant results.
    The resulting studies are often large enough to be informative about direction,
    but not large enough to make repeated significance routine.

- This is "qualified optimism":
  the model says something about the statistical information in typical studies from
  these reference classes. It does not make an individually dubious design,
  analysis, or paper trustworthy.

Keep this fairly sparse. The anthropic-principle point can be spoken rather than
explained at length on the slide.


## Slide 28 — Which common metascience tropes survive the empirical data?
SUBTITLE: An opinionated summary
SOURCE: ADAPT CGD "Possible implications for metascience", UPDATED
STATUS: REWORK OLD TABLE

Purpose:
- End the paper section with a broader interpretation.
- Clearly distinguish conclusions supported by this analysis from questions the model
  is not designed to answer.

Suggested table:

| Common claim | My current take |
| --- | --- |
| **Significant results often fail to replicate significantly** | **Yes.** Low rates of significant same-direction replication are entirely compatible with the distributions we observe. |
| **Most studies are "cursed" by low power** | **Broadly, with qualifications.** Most studies have modest true PoS and only a minority reach 80% power. But researchers do not know the true effect when choosing sample size, so this is not simply evidence of bad study planning. |
| **Most published results are false** | **Not a useful description.** The binary true/false framing misses the distinction between magnitude, sign, and repeated significance. |
| **Some fields are bad while others are "gold standard"** | **Not useful at this level of generality.** There are quantitative differences across corpora, but the same basic features of the distributions recur across very different fields. |
| **We should lower the conventional p-value threshold to 0.01 or 0.001** | **Does not follow from these results.** A more stringent significance threshold does not resolve the underlying distinction between observed z, latent SNR, and replication probability. |
| **We should simply double sample sizes** | **Does not follow.** More precision is useful, but uniformly scaling every study is not a general solution to uncertainty about the underlying effect size. |
| **Publication bias is common** | **This analysis does not establish that.** We allow for selection to recover the underlying distributions, but the selection parameter should not be read as a clean measure of publication bias across fields. |
| **p-hacking is common** | **This analysis says little about it.** Researcher degrees of freedom and p-hacking are not identified by this model. |
| **Replication deserves more research funding** | **Plausible, but not a conclusion of this model.** The model helps clarify what replication outcomes mean; it does not determine the optimal allocation of research funding. |

DESIGN NOTE:
- Probably better visually as three categories rather than a dense two-column table:
    1. SURVIVES
    2. NEEDS QUALIFICATION / REFRAMING
    3. NOT ANSWERED BY THIS PAPER
- Possible allocation:

  SURVIVES:
    - Significant results often fail to replicate significantly.
    - Most studies have modest true power / PoS.

  NEEDS QUALIFICATION OR REFRAMING:
    - "Most published results are false."
    - Some fields are bad and others gold standard.
    - Lower p-value thresholds.
    - Uniformly increasing sample sizes.

  NOT ANSWERED HERE:
    - How common publication bias is.
    - How common p-hacking is.
    - How much research funding should go to replication.

- Keep the wording slightly provocative but statistically precise.
- This is explicitly the presenter's interpretation, rather than another formal
  result from the paper.

END OF PAPER PRESENTATION.
No separate replication-programmes / Gold Standard Science section for now.

# OPTIONAL / BACKUP MATERIAL FROM MODEL AND RESULTS

## Backup A — Full censoring likelihood
SOURCE: PAPER
- Only if someone asks exactly how p < x reports are treated.

## Backup B — Full conditional SNR | z derivation
SOURCE: PAPER APPENDIX
- q_i(z), mu_i(z), tau_i.

## Backup C — All corpus fits
SOURCE: PAPER FIGURE
- Full figure rather than selected 8–10 panels.

## Backup D — Subgroups
SOURCE: PAPER
- Cochrane specialties.
- ClinicalTrials.gov trial phases.
- Useful evidence that decreasing |z| distributions also appear within narrower
  research areas.

