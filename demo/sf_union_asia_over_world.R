library(ggplot2)
library(spData)
library(magrittr)
library(RspatialPkg)

library(rnaturalearth)
library(rnaturalearthdata)

# Subset the simple feature data.frame of `spData::world`
#   where continent equals "Asia":
world_asia_sf <- spData::world[spData::world$continent == "Asia", ]

# Show world_asia_sf
head(world_asia_sf)

#  Combine the MULTIPOLYGON geometries of the asian countries into a single MULTIPOLYGON --
asia_sf <- sf::st_as_sf(sf::st_union(world_asia_sf))

# Show asia_sf which has gone from 47 features to 1 feature
head(asia_sf)

# Map asia_sf
RspatialPkg::get_geom_sf(sf = asia_sf)

# Layer simple feature spData::world with asia_sf filled as "red"
RspatialPkg::get_geom_sf(sf = spData::world) %>%
RspatialPkg::get_geom_sf(
  gg = .,
  sf = asia_sf,
  sf_fill = "red"
)

# comparing default ggplot2::geom_sf with RspatialPkg::get_geom_sf
world_sf <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
ggplot2::ggplot(data = world_sf) +
  geom_sf() +
  coord_sf(expand = FALSE)

RspatialPkg::get_geom_sf(
  sf = world_sf,
  panel_color = "lightblue",
  grid_line_color = "navy"
)
