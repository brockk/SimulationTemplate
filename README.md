---
title: "Simulation study template"
date: "01 February, 2023"
output: 
  html_document:
    keep_md: true
---



# Introduction
This RProject provides a template for laying out the files and folders when conducting a simulation study.

The project layout was developed by Kristian Brock for UCB so that the simulation study would be:

* Portable (i.e. can run anywhere)
* Recoverable (i.e. can resume when interrupted)
* Adaptable (i.e. can add new methods easily)
* Modular (i.e. allows running in parts)

See `/JobScripts/README.md` for information on running the jobs.

# Requirements
This example requires that you have the following packages installed:

* tidyverse

To run jobs in the RStudio Jobs pane, you will also need:

* rstudioapi

# Usage
To use this project as the template in your simulation study, follow these steps:

1. Clone this repository and rename as required (e.g. MyProject) using:

`git clone https://github.com/brockk/SimulationTemplate MyProject`

and then run the following steps:

2. `cd MyProject`

3. Delete the .git directory using `rm -rf .git` (or otherwise) to remove the associated git information, including the original remote location (it is no longer relevant)

4. `git init .`

5. `git add .`

6. `git commit -m "First commit"`

7. Create a new empty repository on your remote of choice (or don't if you don't want a remote). Name your repo with the name you chose above for your project (e.g. MyProject). Uncheck `Add a README`. Set `Add a .gitignore:` to `None`, etc because we want a blank repo.

8. Using the URL of the repo created in step 7, run `git remote add origin myurl`

9. `git push -u origin --all`

Then, assuming you are happy with RStudio, open the project in RStudio and hit `CTRL + SHIFT + F` to bring up the global search dialogue, and search for the string `USERCHOICE`.
This will flag all the places where you need to edit the code to implement the choices specific to your project.
