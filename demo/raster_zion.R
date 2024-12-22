library(ggplot2)
library(RColorBrewer)
library(terra)
library(spDataLarge)
library(RspatialPkg)

raster_filepath <- system.file("raster/srtm.tif", package = "spDataLarge")
zion_park_sr <- terra::rast(raster_filepath)
zion_park_df <- as.data.frame(zion_park_sr, xy = T)
str(zion_park_df)

RspatialPkg::get_geom_raster(
  df = zion_park_df,
  aes_x = "x",
  aes_y = "y",
  aes_fill = "srtm",
  title = "Elevations from Zion National Park",
  subtitle = "Conversion from SpatRaster to data frame to geom_raster",
  scale_colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
  scale_breaks = seq(from = 1000, to = 3000, by = 250),
  scale_labels = seq(from = 1000, to = 3000, by = 250)
)
