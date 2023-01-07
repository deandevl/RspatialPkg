library(ggplot2)
library(spData)
library(RColorBrewer)
library(RspatialPkg)

# Plot world with a fill aesthetic based on its "pop" attribute
world_pop_plot <- RspatialPkg::get_geom_sf(
  sf = spData::world,
  aes_fill = "pop",
  title = "World Population",
  center_titles = T,
  legend_key_width = 0.8
) +
  ggplot2::scale_fill_gradientn(
    colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
    n.breaks = 8
  ) +
  ggplot2::guides(
    fill = ggplot2::guide_colorbar(
      ticks.colour = "black"
    )
  )
world_pop_plot
