library(sf)
library(ggplot2)
library(RspatialPkg)

# ------------------------Set the point geometry in a matrix----------------
# Set point by assigning longitude (column 1) and latitude (column 2)
point_mt <- matrix(data = c(1, -85.386667,  37.941667), nrow = 1, byrow = TRUE)
colnames(point_mt) <- c("idx", "long", "lat")
# Convert point_mt to a simple feature
point_sf <- RspatialPkg::matrix_to_sf(a_matrix = point_mt, xy_v = c("long","lat"))
point_sf

# --------------------Set polygon area of interest
# Set geometries by assigning longitude (column 2)
#  and latitude (column 3) of a rectangle matrix of points
polygon_mt <- rbind(
  c(1, -85.38993, 37.94048),
  c(2, -85.38993, 37.94339),
  c(3, -85.38422, 37.94339),
  c(4, -85.38422, 37.94048),
  c(5, -85.38993, 37.94048))
colnames(polygon_mt) <- c("idx", "long", "lat")

# Create an sf::sf simple features object
polygon_sf <- RspatialPkg::matrix_to_sf(
  a_matrix = polygon_mt,
  xy_v = c(2, 3)
)
polygon_sf

# Map the polygon simple feature
polygon_plot <- RspatialPkg::get_geom_sf(
  sf = polygon_sf,
  sf_fill = "green",
  sf_size = 6,
  panel_color = "yellow"
)
polygon_plot
