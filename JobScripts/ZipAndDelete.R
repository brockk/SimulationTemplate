
# This script zips and removes directories.
#
# Note - this script may not work on Windows.
# Unfortunately, utils::zip can fail silently under Windows.

# For safety, only remove directories if a matching zip file exists.

library(tidyverse)
library(utils)

data_files <- list.files(path = "Data/", recursive = TRUE, full.names = TRUE)
if(length(data_files) > 0) data_files %>% zip(zipfile = 'Data', files = .)
if(file.exists("Data.zip")) unlink("Data", recursive = TRUE)

# USERCHOICE - reuse this trio of lines for each dir targeted for zipping  
mod_files <- list.files(path = "Model1/", recursive = TRUE, full.names = TRUE)
if(length(mod_files) > 0) mod_files %>% zip(zipfile = 'Model1', files = .)
if(file.exists("Model1.zip")) unlink("Model1", recursive = TRUE)
