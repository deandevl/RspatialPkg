library(terra)
library(sf)
library(purrr)
library(data.table)
library(ggplot2)
library(magrittr)
library(RspatialPkg)

data_str <- system.file("ex/lux.shp", package = "terra")
data_spa_v <- terra::vect(data_str)
data_spa_v

# info on SpatVector object
# str(data_spa_v)
# data_names <- terra::names(data_spa_v)
# n_rows <- terra::nrow(data_spa_v)
# n_cols <- terra::ncol(data_spa_v)
# data_extent <- terra::ext(data_spa_v) %>%
#   as.vector()
# data_crs <- terra::crs(data_spa_v)
# data_res <- terra::res(data_spa_v)
# data_df <- terra::as.data.frame(data_spa_v)

# convert SpatVector to data.table
data_dt <- data.table::as.data.table(data_spa_v)
# add population and geometry columns
data_dt[, `:=`(population = 1000*(1:12)^2, geometry = terra::geom(data_spa_v, wkb=TRUE))]
# convert data.tabe to sf object
data_sf <- sf::st_as_sf(data_dt, sf_column_name = "geometry")
# show structure
str(data_sf)

# create dots SpatVector using RspatialPkg::dot_density_sf()
dots_sf <- RspatialPkg::dot_density_sf(
  sf = data_sf,
  dot_col = "population",
  cases_per_dot = 1000,
  group_col = NULL
)

# plot the dots
RspatialPkg::get_geom_sf(
  sf = data_sf,
) +
RspatialPkg::get_geom_sf(
  sf = dots_sf,
  sf_color = "red",
  sf_fill = "red",
  sf_size = 2,
  adding = T
)
