library(ggplot2)
library(sf)
library(magrittr)
library(data.table)
library(spData)
library(RColorBrewer)
library(RspatialPkg)

world_dfr_sf = sf::st_read(
  system.file("shapes/world.shp",
    package = "spData"
  )
)

continents <- unique(world_dfr_sf$continent)
colors <- RColorBrewer::brewer.pal(8, "Set1")
names(colors) <- continents

world_dfr_sf <- world_dfr_sf %>%
  data.table::as.data.table(.) %>%
  .[, continent := as.factor(continent)] %>%
  sf::st_as_sf(.)

world_centroid_sf <- sf::st_centroid(world_dfr_sf, of_largest_polygon = TRUE) %>%
  data.table::as.data.table(.) %>%
  .[, pop_sz := sqrt(world_dfr_sf$pop) / 10000] %>%
  sf::st_as_sf(.)

RspatialPkg::get_geom_sf(
  sf = world_dfr_sf,
  aes_fill = "continent",
  scale_breaks = continents,
  scale_labels = continents,
  scale_values = colors,
  hide_x_tics = T,
  hide_y_tics = T,
  panel_color = "white",
  panel_border_color = "white",
  na_rm = T
) %>%
RspatialPkg::get_geom_sf(
  gg = .,
  sf = world_centroid_sf,
  aes_size = "pop_sz",
  own_scale = T,
  sf_shape = 21,
  sf_fill = "darkred",
  na_rm = T
) +
ggplot2::scale_size(
  breaks = seq(0, 4, 0.5),
  labels = seq(0, 4, 0.5),
)

