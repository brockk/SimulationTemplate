
library(here)
sim_dir <- paste0(here(""), "/")

library(tidyverse)

# Load parameters & create scenarios ----
# USERCHOICE - this regex string expects scenario names like Scenario1a and
# Scenario2b - change this to match your nomenclature.
sc_dir_regex <- "Scenario[1-9][a-z]$"
scenario_dirs <- list.dirs(path = sim_dir, recursive = FALSE) %>%
  keep(~ str_detect(.x, pattern = sc_dir_regex))
params <- scenario_dirs %>%
  map(~ {
    env <- new.env()
    source(paste0(.x, "/Parameters.R"), local = env)
    env
  }) %>%
  set_names(nm = str_extract(scenario_dirs, pattern = sc_dir_regex))
scenarios <- params %>% 
  map(as.list) %>% 
  map(keep, is.numeric) %>% 
  imap(~ as_tibble(.x) %>% mutate(Scenario = .y)) %>% 
  reduce(bind_rows)
# Rows in scenarios should be unique. Check:
assertthat::assert_that(
  scenarios %>% distinct() %>% nrow == scenarios %>% nrow()
)



# Load outputs ----
df <- scenarios %>%
  pull(Scenario) %>%
  map(~ readRDS(paste0(sim_dir, .x, "/df.Rds")) %>%
        mutate(Scenario = .x)) %>%
  reduce(bind_rows)

# USERCHOICE - edit these lines to load your aggregated objects:
estimates <- bind_rows(
  scenarios %>%
    pull(Scenario) %>%
    map(~ readRDS(paste0(sim_dir, .x, "/Model_estimates.Rds")) %>%
          mutate(Scenario = .x)) %>%
    reduce(bind_rows) %>% 
    mutate(Model = "MyModel"),
) %>% 
  mutate(Model = fct_inorder(Model))

times <- bind_rows(
  scenarios %>%
    pull(Scenario) %>%
    map(~ readRDS(paste0(sim_dir, .x, "/Model_time.Rds")) %>%
          mutate(Scenario = .x)) %>%
    reduce(bind_rows) %>% 
    mutate(Model = "MyModel"),
) %>% 
  mutate(Model = fct_inorder(Model))
