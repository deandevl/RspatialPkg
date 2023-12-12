library(ggplot2)
library(RColorBrewer)
library(RspatialPkg)

# Take the ggplot2::faithfuld with "waiting" time on x axis and "eruptions"
#   on the y axis. Use "density" as the fill aesthetic.

# Plot the raster stars object
RspatialPkg::get_geom_raster(
  df = ggplot2::faithfuld,
  aes_x = "waiting",
  aes_y = "eruptions",
  aes_fill = "density",
  title = "2d density estimate of Old Faithful data",
  subtitle = "Source: ggplot2::faithfuld",
  scale_colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd")
)
