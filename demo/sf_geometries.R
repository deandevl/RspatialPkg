library(ggplot2)
library(sf)
library(magrittr)
library(RspatialPkg)

# Create a sfc based polygon
polygon_mat <- cbind(
  x = c(0,0,1,1,  0),
  y = c(0,1,1,0.5,0)
)
polygon_sfc <- sf::st_sfc(sf::st_polygon(list(polygon_mat)))
polygon_sfc

# Create a set of points simple feature
points_df <- data.frame(
  x = c(0.2, 0.7, 0.4),
  y = c(0.1, 0.2, 0.8)
)
points_sf <- sf::st_as_sf(points_df, coords = c("x", "y"))
points_sf

# Create a sfc based line geometry
line_sfc <- sf::st_sfc(sf::st_linestring(cbind(
  x = c(0.4, 1),
  y = c(0.2, 0.5)
)))
line_sfc

# Display the above three geometries separately.
polygon_plot <-
  RspatialPkg::get_geom_sf(
    sf = polygon_sfc,
    sf_color = "blue",
    sf_linewidth = 4,
    sf_fill = "green"
  )
polygon_plot

points_plot <-
  RspatialPkg::get_geom_sf(
    sf = points_sf,
    sf_color = "red",
    sf_fill = "blue",
    sf_stroke = 4,
    sf_size = 8.0
  )
points_plot

line_plot <-
  RspatialPkg::get_geom_sf(
    sf = line_sfc,
    sf_color = "red",
    sf_linewidth = 8
  )
line_plot

# Display the above three geometries together.
RspatialPkg::get_geom_sf(
  sf = polygon_sfc,
  sf_color = "purple",
  sf_linewidth = 4,
  sf_fill = "yellow",
  title = "Overlaid geometries of polygon_sfc, points_sf, and line_sfc"
) %>%
RspatialPkg::get_geom_sf(
  sf = points_sf,
  sf_color = "red",
  sf_fill = "blue",
  sf_size = 8.0,
  sf_stroke = 4
) %>%
RspatialPkg::get_geom_sf(
  sf = line_sfc,
  sf_color = "green",
  sf_linewidth = 8
)
