library(tidyverse)
library(baggr)
library(readr)
dt <- read_csv("data/nudge/mhhb_nma_data_corrected.csv")

# There is also a very nice list of corrections, but I will ignore it here
# dt2 <- read_csv("mhhb_nma_corrections.csv")
names(dt)

dt$cohens_d
hist(dt$cohens_d)
hist(dt$variance_d)

# On average the results are significant
summary(abs(dt$cohens_d / sqrt(dt$variance_d)))

library(metafor)

?rma

rma(yi = cohens_d, vi = variance_d, data = dt)
rma(yi = cohens_d, vi = variance_d, data = dt, method = "EE")
rma(yi = cohens_d, vi = variance_d, data = dt, method = "DL")
rma(yi = cohens_d, vi = variance_d, data = dt, method = "REML")

metafor::funnel(dt$cohens_d, vi = dt$variance_d) #not good at all!
regtest(dt$cohens_d, vi = dt$variance_d)



# Large models: parallel processing
options(mc.cores = 4)

bg <- dt %>% 
  transmute(tau = cohens_d, se = sqrt(variance_d), group = reference) %>% 
  baggr()

funnel(bg)
# can still plot, but what's the point?
plot(bg) + theme(axis.text.y = element_blank()) 

# model with selection
# ~3 mins on my laptop
bg_sel <- dt %>% 
  transmute(tau = cohens_d, se = sqrt(variance_d), group = reference) %>% 
  baggr(selection = 1.96)

save(bg, bg_sel, file = "results/nudges.Rdata")
