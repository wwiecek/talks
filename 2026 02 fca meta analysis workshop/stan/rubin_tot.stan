data {
  int<lower=1> N;                // Number of studies
  vector[N] tau;                 // Observed ITT effects
  vector<lower=0, upper=1>[N] compliance; // Compliance rates (0 to 1)
  vector<lower=0>[N] se;         // Standard errors for ITT effects
  real tau_test;                 // Leave-one-out test ITT effect
  real<lower=0, upper=1> compliance_test; // Leave-one-out compliance rate
  real<lower=0> se_test;         // Leave-one-out standard error
  real mu_mean;
  real mu_sd;
}

parameters {
  real mu;                       // Overall mean TOT effect
  real<lower=0> sigma;           // Between-study SD for TOT effects
  vector[N] eta;                 // Non-centered effects
}

transformed parameters {
  vector[N] TOT;                 // Study-level TOT effects
  TOT = mu + sigma * eta;        // Non-centered parameterization
}

model {
  // Priors
  mu ~ normal(mu_mean, mu_sd);         // Prior for overall mean
  sigma ~ normal(0, 5);          // Prior for between-study SD

  eta ~ normal(0, 1);            // Standard normal prior for non-centered effects

  // Likelihood
  tau ~ normal(compliance .* TOT, se);  // ITT modeled as compliance * TOT
}

generated quantities {
  vector[N] log_lik;
  real log_lik_test;             // Log-likelihood for leave-one-out study

  for (i in 1:N) {
    log_lik[i] = normal_lpdf(tau[i] | compliance[i] * TOT[i], se[i]);
  }
  
  // Compute leave-one-out log-likelihood
  log_lik_test = normal_lpdf(tau_test | compliance_test * mu, sqrt(sigma^2 * compliance_test^2 + se_test^2));
}
