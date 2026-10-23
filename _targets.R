################################################################################
# Title: Targets script
# Author: A. M. Stubbe
# Date: 23-10-2026
# Purpose: create analysis
# User guideline:
#   do not change anything in the code
#   load the packages
#   to produce the outputs of the study, run tar_make() in the Console
#   to open the quarto html, run browseURL("gentoo_quarto.html") in the Console
################################################################################

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)

# Set target options:
tar_option_set(
  packages = c("tidyverse", "here")
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()


list(
  # data file
  tar_target(
    name = penguin_file,
    command = here("data/penguins.csv"),
    format = "file" # Efficient storage for general data objects
  ),

  # import data file
  tar_target(
    name = penguin_df,
    command = read_delim(file = penguin_file)
  ),

  # clean
  tar_target(
    name = gentoo_df,
    command = cleaning_data(penguin_df, species = "Gentoo")
  ),

  # plot
  tar_target(
    name = gentoo_plot,
    command = plotting_body_mass(gentoo_df)
  ),

  # save plot
  tar_target(
    name = gentoo_plot_file,
    command = saving_plot(
      gentoo_plot,
      filename = "gentoo_body_mass.png"
    ),
    format = "file"
  ),

  # quatro
  tar_quarto(
    name = manuscript,
    path = "gentoo_quarto.qmd")
)
