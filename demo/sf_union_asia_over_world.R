library(ggplot2)
library(RspatialPkg)
library(spData)

library(rnaturalearth)
library(rnaturalearthdata)

# Subset the simple feature data.frame of `spData::world`
#   where continent equals "Asia":
world_asia_sf <- spData::world[spData::world$continent == "Asia", ]

# Show world_asia_sf
world_asia_sf

#  Combine the MULTIPOLYGON geometries of the asian countries into a single MULTIPOLYGON --
asia_sf <- sf::st_as_sf(sf::st_union(world_asia_sf))

# Show asia_sf which has gone from 47 features to 1 feature
asia_sf

# Map asia_sf
asia_plot <- RspatialPkg::get_geom_sf(sf = asia_sf)
asia_plot

# Layer simple feature spData::world with asia_sf filled as "red"
layer_world_asia_plot <-
  RspatialPkg::get_geom_sf(sf = spData::world) +
  RspatialPkg::get_geom_sf(
    sf = asia_sf,
    sf_fill = "red",
    adding = T
)
layer_world_asia_plot

# comparing default ggplot2::geom_sf with RspatialPkg::get_geom_sf
world_sf <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
ggplot2::ggplot(data = world_sf) +
  geom_sf() +
  coord_sf(expand = FALSE)

world_plot <- RspatialPkg::get_geom_sf(
  sf = world_sf,
  panel_color = "lightblue",
  grid_line_color = "navy"
)
world_plot


