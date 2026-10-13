library(tidyverse)
library(metafor)
library(baggr)

water <- readRDS("data/water.rds")  %>% 
  mutate(y2000 = (year - 2000)/10,
         compliance = ifelse(is.na(compliance), 
                             mean(compliance, na.rm=T), 
                             compliance))


rma(data = water, yi = logor, sei = se_logor)
rma(data = water, yi = logor, sei = se_logor, method = "FE")
# These are the same! Why?

rma(data = water, yi = logor, sei = se_logor, method = "SJ")

metafor::funnel(water$logor, sei = water$se_logor) #funnel not very informative 
rma(data = water, yi = logor, sei = se_logor) %>% forest

bg_p <- water %>% 
  rename(tau = logor, se = se_logor) %>% 
  baggr(model = "rubin", group = "trial_name")

bg_p
plot(bg_p, hyper = TRUE, transform = exp)

bg_full <- water %>% 
  rename(tau = logor, se = se_logor) %>% 
  baggr(model = "rubin", group = "trial_name", pooling = "full")

baggr_compare("partial" = bg_p, "full" = bg_full)
baggr_compare("partial" = bg_p, "full" = bg_full) %>% plot

funnel(bg_full)
funnel(bg_p) #with a bit of heterogeneity it becomes funnel, not a triangle!

# Meta-regression
# options(mc.cores = NULL)
bg_cov <- water %>% 
  rename(tau = logor, se = se_logor) %>% 
  baggr(model = "rubin", group = "trial_name", pooling = "partial",
        covariates = c("compliance", "y2000"))






