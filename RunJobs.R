
library(rstudioapi)
library(here)

simulation_root <- paste0(here(""), "/")
job_script_dir <- paste0(here("JobScripts"), "/")


# USERCHOICE - reuse this pattern to run the job scripts for each model for each
# data-generating method / scenario.
# Scenario 1a ----
rstudioapi::jobRunScript(
  path = paste0(job_script_dir, "CreateDatasets.R"),
  name = "CreateDatasets - Scenario 1a",
  workingDir = paste0(simulation_root, "Scenario1a/")
)
rstudioapi::jobRunScript(
  path = paste0(job_script_dir, "FitModel.R"),
  name = "FitModel - Scenario 1a",
  workingDir = paste0(simulation_root, "Scenario1a/")
)
# rstudioapi::jobRunScript(
#   path = paste0(job_script_dir, "FitOtherModel.R"),
#   name = "FitOtherModel - Scenario 1a",
#   workingDir = paste0(simulation_root, "Scenario1a/")
# )
rstudioapi::jobRunScript(
  path = paste0(job_script_dir, "LoadStackAndSave.R"),
  name = "LoadStackAndSave - Scenario 1a",
  workingDir = paste0(simulation_root, "Scenario1a/")
)
rstudioapi::jobRunScript(
  path = paste0(job_script_dir, "ZipAndDelete.R"),
  name = "ZipAndDelete - Scenario 1a",
  workingDir = paste0(simulation_root, "Scenario1a/")
)

# Unzip ----
# If and when necessary, unzip and restore:
# rstudioapi::jobRunScript(
#   path = paste0(job_script_dir, "UnzipAndRestore.R"),
#   name = "UnzipAndRestore - Scenario 1a",
#   workingDir = paste0(simulation_root, "Scenario1a/")
# )
