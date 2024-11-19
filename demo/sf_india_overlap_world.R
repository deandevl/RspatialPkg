library(ggplot2)
library(spData)
library(magrittr)
library(RspatialPkg)

# Show the class of spData::world is a simple feature object
class(spData::world)

# Subset the Asian countries geom's from spData::world
world_asia_sf <- spData::world[spData::world$continent == "Asia", ]

# Subset further and get the geom's just for "India"
india_sf <-  spData::world[spData::world$name_long == "India", ]

# Map India (india_sf) with a "red" fill over Asia (world_asia_sf) simple feature
RspatialPkg::get_geom_sf(
  sf = world_asia_sf,
  sf_fill = "green",
  sf_alpha = 0.6,
  title = "Overlap India over Asia",
  subtitle = "Source: spdata::world"
) %>%
RspatialPkg::get_geom_sf(
  sf = india_sf,
  sf_fill = "red"
)
