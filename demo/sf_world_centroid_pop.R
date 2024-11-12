library(ggplot2)
library(sf)
library(magrittr)
library(data.table)
library(spData)
library(RColorBrewer)
library(RspatialPkg)

# Create a map of continents with overlaid circles whose diameters
#   represent country populations.

# Show spData::world simple feature object
# Note that the geometry type is MULTIPOLYGON
spData::world

# Transform/project the geometries of spData::world to crs = "+proj=eck4"
world_proj_sf <- sf::st_transform(spData::world, crs = "+proj=eck4")

# Compute the centroid geom points for each country
# Return centroid of the largest (sub) polygon of a MULTIPOLYGON
world_centroids_sf <- sf::st_centroid(world_proj_sf, of_largest_polygon = TRUE)

# Show the world_centroids_sf simple feature object
# Note that the geometry type is now POINT
world_centroids_sf

# Create a vector that holds a scaling of the raw population numbers
cex_v <- sqrt(spData::world$pop) / 10000

# Combine the centroid data with scaled pop numbers
world_centroids_sf <- cbind(world_centroids_sf, cex_v)

# Map the world overlaid with the centroid points as circles whose
#   size reflect the country's scaled pop numbers
# Map the fill aesthetic to the variable "continent" of the spData::world simple feature
# Map the size aesthetic to the variable "cex_v" of the world_centroids_sf simple feature
#

world_sf <- data.table::as.data.table(spData::world) %>%
  .[, continent := as.factor(continent)] %>%
  sf::st_as_sf(.)

continents <- unique(world_sf$continent)
colors <- RColorBrewer::brewer.pal(8, "Set1")
names(colors) <- continents

world_centroid_pop_plot <- RspatialPkg::get_geom_sf(
  sf = world_sf,
  aes_fill = "continent",
  title = "Overlaid circles representing country populations",
  center_titles = T,
  scale_breaks = continents,
  scale_labels = continents,
  scale_values = colors,
  na_rm = T
) + RspatialPkg::get_geom_sf(
  sf = world_centroids_sf,
  aes_size = "cex_v",
  sf_shape = 21,
  sf_fill = "darkred",
  na_rm = T,
  adding = T
) + ggplot2::scale_size(
      breaks = seq(0, 4, 0.5),
      labels = seq(0, 4, 0.5),
   )

world_centroid_pop_plot





