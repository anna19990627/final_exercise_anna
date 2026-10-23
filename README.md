# Gentoo Study

## Content
- data - contains all data necessary to create the results of our study
- R - contains scripts with code/ functions that were used to clean and plot the data
- _targets. - an organised manner to run all the steps carried out during data processing


## How to reproduce the results
- download the content of this repository into a local folder
- open the project
- if you do not have tidyverse, here, targets and/or tarchetypes installed, run
  install.packages("packagename") in the console
- open -targets.R
- read in the libraries
- run tar_make() in the console to create the outputs of the study
- run browseURL("gentoo_quarto.html") to create the paper "Gento study"
