data {
  int<lower=1> N;            // Number of studies
  vector[N] tau;             // Observed effects
  vector<lower=0>[N] se;     // Standard errors
  real tau_test;             // Leave-one-out test effect size
  real<lower=0> se_test;     // Leave-one-out test standard error
  real mu_mean;
  real mu_sd;
}

parameters {
  real mu;                   // Overall mean effect
  real<lower=0> sigma;       // Between-study standard deviation
  vector[N] eta;             // Non-centered effects
}

transformed parameters {
  vector[N] theta;           // Study-level effects
  theta = mu + sigma * eta;  // Non-centered parameterization
}

model {
  // Priors
  mu ~ normal(mu_mean, mu_sd);         // Prior for overall mean
  sigma ~ normal(0, 5);      // Prior for between-study SD

  eta ~ normal(0, 1);        // Standard normal prior for non-centered effects

  // Likelihood
  tau ~ normal(theta, se);   // Data likelihood
}
generated quantities {
  vector[N] log_lik;
  real log_lik_test;         // Log-likelihood for leave-one-out study
  for (i in 1:N) {
    log_lik[i] = normal_lpdf(tau[i] | theta[i], se[i]);
  }
  // Compute leave-one-out log-likelihood
  log_lik_test = normal_lpdf(tau_test | mu, sqrt(sigma^2 + se_test^2));
}
