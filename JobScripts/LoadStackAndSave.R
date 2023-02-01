
library(tidyverse)

load_and_stack_csv <- function(path, pattern) {
  files <- list.files(path = path, pattern = pattern,
                      recursive = TRUE, full.names = TRUE)
  if(length(files) > 0) {
    files %>%
      imap(
        ~ read.csv(.x) %>%
          as_tibble() %>%
          mutate(i = str_extract(.x, "/\\d+/") %>% str_extract("\\d+"))
      ) %>%
      reduce(bind_rows)
  } else {
    data.frame()
  }
}

# Simulated data
load_and_stack_csv(path = "Data/", pattern = "^df.csv$") %>%
  saveRDS(file = "df.Rds")

# USERCHOICE - adapt to reflect your model names (in the path param), outputs
# (in the pattern param), and target file names (in the file param)
# Model outputs
load_and_stack_csv(path = "Model/", pattern = "^model.csv$") %>%
  saveRDS(file = "Model_estimates.Rds")
load_and_stack_csv(path = "Model/", pattern = "^time.csv$") %>%
  saveRDS(file = "Model_time.Rds")
