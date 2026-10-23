################################################################################
# Title: Function script
# Author: A. M. Stubbe
# Date: 23-10-2026
# Purpose: creating functions that are used in the final script
################################################################################

# 1 Loading necessary packages ####

library(tidyverse)

# 2 Cleaning Function ####

# As the study focuses on Gentoo, we will select for this species.
# This function makes sure, that the species that we are interested in,
# is in the df. If not, it will tell us what species are in the df.
# Furthermore, we select for the variables of interest (species, body_mass, year,
# sex) and drop rows with missing values from these.

cleaning_data <- function(.data, species) {

  # Get all available species
  available_species <- sort(unique(as.character(.data$species)))

  # Check if requested species exists
  if (!species %in% available_species) {
    stop(
      paste0(
        "Species '", species, "' not found in dataset.\n",
        "Available species: ",
        paste(available_species, collapse = ", ")
      ),
      call. = FALSE
    )
  }

  # Clean and filter data
  .data |>
    dplyr::select(species, body_mass, sex, year) |>
    filter(.data$species == .env$species) |>
    drop_na() |>
    droplevels()
}


# 3 Plotting Body Mass over the years ####

## 3.1 creating the plot ####
# This function plottes the body mass of Gentoo over the years to see if there
# is a temporal trend. We did split it up between male and female, as males have
# shown to be more vulnerable.

plotting_body_mass <- function(.data) {

  # Identify species in the dataset
  species_name <- unique(as.character(.data$species))

  # Check that exactly one species is present
  if (length(species_name) != 1 || is.na(species_name)) {
    stop(
      paste0(
        "Expected exactly one species, but found: ",
        paste(species_name, collapse = ", ")
      ),
      call. = FALSE
    )
  }

  # Create plot
  .data |>
    mutate(year = as.factor(year)) |>
    ggplot(aes(x = year, y = body_mass, colour = sex)) +
    geom_boxplot() +
    labs(
      x = "Year",
      y = "Body Mass (g)",
      title = paste("Trends of body mass of", species_name)
    ) +
    theme_bw()
}

## 3.2 saving the plot ####

saving_plot <- function(.plot, filename = "body_mass.png") {

  # Check if the plot exists and is a ggplot object
  if (is.null(.plot) || !inherits(.plot, "ggplot")) {
    stop("Plot does not exist or is not a ggplot object.",
         call. = FALSE)
  }

  # Create plot folder if it does not exist
  if (!dir.exists("plot")) {
    dir.create("plot")
  }

  # Define file path
  plot_path <- file.path("plot", filename)

  # Save plot
  ggplot2::ggsave(
    filename = plot_path,
    plot = .plot,
    width = 8,
    height = 5,
    dpi = 300
  )

  # Return file path
  return(plot_path)
}
