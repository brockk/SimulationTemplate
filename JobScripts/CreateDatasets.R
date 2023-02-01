
# Load common objects:
library(here)
source(here('Common.R'))

# Load parameters specific to this scenario:
source("Parameters.R")

set.seed(seed)
for(i in seq_len(n_sim)) {
  
  # Log
  print(paste0("Running ", i, " of ", n_sim))
  
  # Get dataset, recording pre and post RNG state
  pre_seed <- .Random.seed
  # USERCHOICE - replace with a call to your data-generating mechanism
  df <- get_data(n = n_obs)
  post_seed <- .Random.seed
  
  # Create out directory if not present
  out_dir <- paste0(data_dir_name, i, "/")
  if(!dir.exists(out_dir)) {
    dir.create(out_dir, recursive = TRUE)
  }
  
  # Save
  saveRDS(pre_seed, file = paste0(out_dir, "pre_seed.Rds"))
  write.csv(x = df, file = paste0(out_dir, "df.csv"))
  saveRDS(post_seed, file = paste0(out_dir, "post_seed.Rds"))
  
}
