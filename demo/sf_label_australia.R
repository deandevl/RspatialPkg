library(ggplot2)
library(sf)
library(ozmaps)
library(RspatialPkg)

# Show that ozmaps::ozmap_states is a simple feature
class(ozmaps::ozmap_states)

# Show ozmaps::ozmap_states
ozmaps::ozmap_states

# Map ozmaps::ozmap_states with aesthetic mapping of text with the "NAME" variable
oz_states_plot <- RspatialPkg::get_geom_sf(
  sf = ozmaps::ozmap_states,
  aes_text = "NAME",
  sf_fill = "blue",
  text_color = "red",
  text_size = 4.0,
  text_fontface = "italic",
  text_check_overlap = TRUE,
  panel_color = "brown",
  hide_x_tics = TRUE,
  hide_y_tics = TRUE
)
oz_states_plot
