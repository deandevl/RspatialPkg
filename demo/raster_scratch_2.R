library(ggplot2)
library(terra)
library(RspatialPkg)

# Create a SpatRaster object from scratch using terra::rast()
elev_scratch_sr <- terra::rast(
  names = c("Scratch"),
  nrows = 6,
  ncols = 6,
  resolution = 0.5,
  xmin = -1.5,
  xmax = 1.5,
  ymin = -1.5,
  ymax = 1.5,
  vals = 1:36
)
elev_scratch_sr

# Show the data.frame version of the SpatRaster object
elev_scratch_df <- terra::as.data.frame(
  x = elev_scratch_sr,
  xy = T,
  cells = T
)
str(elev_scratch_df)

# Display the SpatRaster object using RSpatialPkg::get_geom_raster()
RspatialPkg::get_geom_raster(
  df = elev_scratch_df,
  aes_x = "x",
  aes_y = "y",
  aes_fill = "Scratch",
  title = "A Scratch 6x6 cell Raster With Values 1 to 36",
  subtitle = "X-Y extents: -1.5 to 1.5",
  scale_colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
  scale_breaks = seq(from = 0, to = 40, by = 5),
  scale_labels = seq(from = 0, to = 40, by = 5)
)

# Create the same SpatRaster object from a data.frame
x <- seq(-1.25, 1.25, length.out = 6)
y <- seq(-1.25, 1.25, length.out = 6)
elev_scratch_2_df <- expand.grid(x = x, y = y)
elev_scratch_2_df$z <- 1:36
str(elev_scratch_2_df)

# Convert data frame to SpatRaster
elev_scratch_2_df_sr <- terra::rast(elev_scratch_2_df)
terra::crs(elev_scratch_2_df_sr) <- "EPSG:4326"
elev_scratch_2_df_sr

# Display the SpatRaster
df <- as.data.frame(elev_scratch_2_df_sr, xy = T)
RspatialPkg::get_geom_raster(
  df = df,
  aes_x = "x",
  aes_y = "y",
  aes_fill = "z",
  scale_colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd"),
  scale_breaks = seq(from = 0, to = 40, by = 5),
  scale_labels = seq(from = 0, to = 40, by = 5)
)
