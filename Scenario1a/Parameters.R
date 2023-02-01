
# USERCHOICE set number of observations in this scenario
n_obs <- 20
# USERCHOICE set parameters and define DGM in this scenario
mu <- -0.5
sigma <- 2
get_data <- function(n) rnorm(n = n, mean = mu, sd = sigma)
