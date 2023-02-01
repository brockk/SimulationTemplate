
library(here)
source(here('Common.R'))

# USERCHOICE - add libraries required for model-fitting
library(broom) # For tidy model summary

# USERCHOICE - replace with appropriate label for this model
output_dir <- "Model/"
resume <- TRUE

ids <- list.dirs(path = data_dir_name, full.names = FALSE, recursive = FALSE)
for(i in seq_along(ids)) {
  
  id <- ids[i]
  
  # Log
  print(paste0("Running ", i, " of ", length(ids), "; id = ", id))
  
  # Avoid recalculation if resuming a partially completed job:
  out_dir <- paste0(output_dir, id, "/")
  if(dir.exists(out_dir) & resume) next
  
  # Load data
  load_dir <- paste0(data_dir_name, id, "/")
  df <- read.csv(file = paste0(load_dir, "df.csv"))
  
  # Restore RNG to its state immediately post sampling df. This is only required
  # if the model-fitting process involves random numbers. The model fitting
  # routine in glm does not use random numbers so we comment this bit out:
  rng_state <- readRDS(paste0(load_dir, "post_seed.Rds"))
  .Random.seed <- rng_state
  
  # Fit model with error-handling
  tryCatch({
    ti <- system.time({
      # USERCHOICE - replace with a call to your model-fitting routine
      mod <- fit_model(df)
    })
    
    # Output directory
    if(!dir.exists(out_dir)) {
      dir.create(out_dir, recursive = TRUE)
    }
    
    # Outputs
    write.csv(
      tidy(mod), # USERCHOICE - replace with appropriate summary of your model
      file = paste0(out_dir, "model.csv"),
      row.names = FALSE
    )
    write.csv(
      t(as.matrix(ti)),
      file = paste0(out_dir, "time.csv"),
      row.names = FALSE
    )
    
  },
  # Error-handler
  error = function(e) 
    message(
      paste0("Error running i = ", i, ", seed = ", this_seed)
    )
  )
  
}
