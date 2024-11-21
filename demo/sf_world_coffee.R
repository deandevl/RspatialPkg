library(ggplot2)
library(sf)
library(magrittr)
library(data.table)
library(spData)
library(RColorBrewer)
library(RspatialPkg)

coffee_data_dt <- data.table::as.data.table(spData::coffee_data)

world_coffee_sf <- data.table::as.data.table(spData::world) %>%
  coffee_data_dt[., on = c("name_long", "name_long")] %>%
  .[, .(name_long, coffee_production_2017, geom)] %>%
  na.omit(.) %>%
  sf::st_as_sf(.)

RspatialPkg::get_geom_sf(
  sf = spData::world,
  hide_x_tics = T,
  hide_y_tics = T,
  panel_color = "white",
  panel_border_color = "white",
) %>%
RspatialPkg::get_geom_sf(
  gg = .,
  sf = world_coffee_sf,
  aes_fill = "coffee_production_2017",
  subtitle = "Coffee Production for 2017",
  center_titles = T,
  scale_breaks = seq(0,3000,250),
  scale_labels = seq(0,3000,250),
  scale_limits = c(0,3000),
  scale_colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
  legend_key_width = 0.7,
  legend_key_height = 1.0
)
