library(ggplot2)
library(RColorBrewer)
library(terra)
library(RspatialPkg)

# Create a SpatRater object
elev_sr <- terra::rast(
  nrows = 6,
  ncols = 6,
  resolution = 0.5,
  xmin = -1.5,
  xmax = 1.5,
  ymin = -1.5,
  ymax = 1.5,
  vals = 1:36,
  names = c("Scratch")
)
elev_sr

# Convert to data.frame
elev_df <- as.data.frame(elev_sr, xy = T)
# Display elev_spat
elev_plot <- RspatialPkg::get_geom_raster(
  df = elev_df,
  aes_x = "x",
  aes_y = "y",
  aes_fill = "Scratch",
  title = "A Scratch 6x6 cell Raster With Values 1 to 36",
  subtitle = "X-Y extents: -1.5 to 1.5",
  x_major_breaks = seq(from = -1.25, to = 1.25, by = 0.5),
  y_major_breaks = seq(from = -1.25, to = 1.25, by = 0.5),
  scale_colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd")
)
elev_plot

# Creating a clipping raster object
clip_sr <- terra::rast(
  xmin = 0.0,
  xmax = 1.8,
  ymin = -0.45,
  ymax = 0.45,
  resolution = 0.3,
  vals = rep(1,9),
  names = c("Clipper")
)
clip_sr

# Convert clip_sr to data.frame and display
clip_df <- as.data.frame(clip_sr, xy = T)
clip_plot <- RspatialPkg::get_geom_raster(
  df = clip_df,
  aes_x = "x",
  aes_y = "y",
  aes_fill = "Clipper",
  title = "A Clipping 3x6 Raster",
  subtitle = "Resolution: 0.3--Extent: 0, 1.8, -0.45, 0.45  (xmin, xmax, ymin, ymax)",
  show_legend = F,
  scale_colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd")
)
clip_plot

# Get a subset of values from elev_sr using clip_sr
# The function ext() gets the extent of clip_sr
# The values returned are in a data.frame
elev_extent_df <- terra::extract(elev_sr, terra::ext(clip_sr))
str(elev_extent_df)

# Get a subset SpatRaster object by clipping elev_sr with clip_sr
elev_sub_sr <- elev_sr[clip_sr, drop = F]
elev_sub_sr

# Display resulting SpatRaster subset
elev_sub_df <- as.data.frame(elev_sub_sr, xy = T)
elev_sub_plot <- RspatialPkg::get_geom_raster(
  df = elev_sub_df,
  aes_x = "x",
  aes_y = "y",
  aes_fill = "Scratch",
  title = "A 2x3 Sub-Raster",
  subtitle = "Resolution: 0.5--Extent: 0, 1.5, -0.5, 0.5",
  scale_colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd")
)
elev_sub_plot

# Get a subset SpatRaster object by using cell ids
# cells 3 to 5 along y; 2 to 4 along x
elev_sub_ids_sr <- elev_sr[3:5, 2:4, drop = F]
elev_sub_ids_sr

# Display resulting SpatRaster subset
elev_sub_ids_df <- as.data.frame(elev_sub_ids_sr, xy = T)
elev_sub_ids_plot <- RspatialPkg::get_geom_raster(
  df = elev_sub_ids_df,
  aes_x = "x",
  aes_y = "y",
  aes_fill = "Scratch",
  title = "A 3x3 Sub-Raster Using Cell IDs",
  subtitle = "Cells 3 to 5 along y; Cells 2 to 4 along x--Extent: -1, 0.5, -1, 0.5",
  scale_colors = RColorBrewer::brewer.pal(n = 9, name = "YlOrRd")
)
elev_sub_ids_plot
