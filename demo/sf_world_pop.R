library(ggplot2)
library(spData)
library(data.table)
library(sf)
library(magrittr)
library(RColorBrewer)
library(RspatialPkg)

dt_sf <- data.table::as.data.table(spData::world) %>%
  .[, pop := pop/10000] %>%
  sf::st_as_sf(.)

# Plot world with a fill aesthetic based on its "pop" attribute with default scaling
world_pop_plot <- RspatialPkg::get_geom_sf(
  sf = dt_sf,
  aes_fill = "pop",
  title = "World Population",
  center_titles = T,
  legend_key_width = 0.8
)
world_pop_plot

# Repeat with defined scaling
world_pop_2_plot <- RspatialPkg::get_geom_sf(
  sf = dt_sf,
  aes_fill = "pop",
  title = "World Population",
  center_titles = T,
  legend_key_width = 0.8,
  legend_key_height = 1.0,
  scale_breaks = seq(0, 140000, 20000),
  scale_limits = c(0, 140000),
  scale_labels = seq(0, 140000, 20000),
)
world_pop_2_plot

