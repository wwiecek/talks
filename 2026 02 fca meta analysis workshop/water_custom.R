library(tidyverse)
library(baggr)
library(rstan)
rstan_options(auto_write = TRUE)
sm1 <- stan_model("stan/rubin.stan")
sm2 <- stan_model("stan/rubin_tot.stan")

water <- readRDS("data/water.rds")  %>% 
  mutate(y2000 = (year - 2000)/10,
         compliance = ifelse(is.na(compliance), 
                             mean(compliance, na.rm=T), 
                             compliance))



standt <- list(tau = water$logor, 
               se = water$se_logor, 
               compliance = water$compliance,
               N = nrow(water), 
               tau_test = 0, se_test = 1, compliance_test = 0,
               mu_mean = 0, mu_sd = 44)

fit_rubin <- sampling(sm1, data = standt, refresh = 0)
fit_tot <- sampling(sm2, data = standt, refresh = 0)

print(fit_rubin, c("mu", "sigma"))
print(fit_tot, c("mu", "sigma"))
