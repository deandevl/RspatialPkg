library(ggplot2)
library(sf)
library(sfheaders)
library(RspatialPkg)

# Get the long/lat coordinate data for the "world"
world_df <- ggplot2::map_data("world")
str(world_df)

# Create a simple feature object from the long/lat coordinate data
# Note how sfheaders::sf_polygon groups together the polygon geometries by "group" variable
# For example, the first group ("Aruba") has 10 long/lat pairs to describe its polygon
# Looking at the data frame world_sf, a 10 x 2 matrix contains the long/lat pairs for the first group "Aruba"
world_sf <- sfheaders::sf_polygon(
  obj = world_df,
  x = "long",
  y = "lat",
  polygon_id = "group"
)

# Define its coordinate reference system (crs)
sf::st_crs(world_sf) <- "EPSG:4326"
world_sf

# Map the simple feature
# We are limiting it to show just North America
north_america_plot <- RspatialPkg::get_geom_sf(
  sf = world_sf,
  sf_fill = "brown"
) +
ggplot2::coord_sf(
  xlim = c(-179.0, -60.0),
  ylim = c(15.0, 72.0)
)
north_america_plot