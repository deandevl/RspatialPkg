library(ggplot2)
library(RColorBrewer)
library(RspatialPkg)

x <- seq(-1.5, 1.5, length.out = 6)
y <- seq(-1.5, 1.5, length.out = 6)
scratch_df <- expand.grid(x = x, y = y)
scratch_df$z <- runif(nrow(scratch_df))
scratch_df$z4 <- scratch_df$z * 4

RspatialPkg::get_geom_raster(
  df = scratch_df,
  aes_x = "x",
  aes_y = "y",
  aes_fill = "z4",
  title = "Scratch data frame to geom_raster",
  subtitle = "6x6 grid -1.5 to 1.5 with 0.6 resolution",
  x_major_breaks = seq(from = -1.5, to = 1.5, by = 0.6),
  y_major_breaks = seq(from = -1.5, to = 1.5, by = 0.6),
  scale_colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
  scale_breaks = seq(from = 0.0, to = 4.0, by = 0.5),
  scale_labels = seq(from = 0.0, to = 4.0, by = 0.5)
)
