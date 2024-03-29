#' get_geom_sf
#'
#' The function is a wrapper around ggplot2::geom_sf that plots simple feature objects.
#'
#' The function is a wrapper around ggplot2::geom_sf. It accepts objects of class
#'   sf for visualizing their points, lines, and polygon geometries.  The function provides
#'   parameters for controlling color, size, variable aesthetic mapping, and text labeling.
#'
#' If a variable for size, color, or fill aesthetic mapping is defined, then parameters for scaling
#'   the variable are provided.
#'
#' See \href{https://r-spatial.github.io/sf/articles/sf1.html}{Simple Features for R}
#'   for more information on simple features.
#'
#' For a good introduction to using ggplot2::geom_sf
#'   see \href{https://r-spatial.org/r/2018/10/25/ggplot2-sf.html}{Drawing beautiful maps programmatically with R, sf and ggplot2}.
#'
#' @param sf A simple features object of class "sf".
#' @param adding A logical which if TRUE then the ggplot2::ggplot() object is *NOT* created and
#'  only a geom object is returned for subsequent adding.
#' @param aes_color The variable name from \code{sf} for the dependent aesthetic mapping for color.
#' @param aes_fill The variable name from \code{sf} for the dependent aesthetic mapping for fill.
#'   If the variable is a discrete factor, see ggplot2::scale_fill_manual() for appropriate scaling values.
#'   If the variable is continuous, see ggplot2::scale_fill_gradientn().
#' @param aes_size The variable name from \code{sf} for the dependent aesthetic mapping for point size.
#' @param aes_text The variable name from \code{sf} for the dependent aesthetic mapping for text labeling.
#' @param text_size A numeric value that sets the size of aesthetic mapping of text (i.e. aes_text)
#' @param text_color A string that sets the color of aesthetic mapping of text color (i.e. aes_text)
#' @param text_fontface A string that sets the fontface of aesthetic mapping of text fontface (i.e. aes_text).
#'  Acceptable values: "plain", "bold", "italic", "bold.italic". The default is "plain".
#' @param text_check_overlap A logical which if TRUE will not plot text that overlaps.
#' @param text_nudge_x A numeric that sets the value for nudging the text in the x direction.
#' @param text_nudge_y A numeric that sets the value for nudging the text in the y direction.
#' @param title A string that sets the plot title.
#' @param subtitle A string that sets the plot subtitle.
#' @param caption A string that sets the plot caption
#' @param center_titles A logical which if \code{TRUE} centers both the \code{title} and \code{subtitle}.
#' @param x_title A string that sets the x axis title. If NULL (the default)  then the x axis title does not appear.
#' @param y_title A string that sets the y axis title. If NULL (the default)  then the y axis title does not appear.
#' @param hide_x_tics A logical that controls the appearance of the x axis tics.
#' @param hide_y_tics A logical that controls the appearance of the y axis tics.
#' @param panel_color A string in hexidecimal or color name that sets the plot panel's color.
#'   The default is "white".
#' @param panel_border_color A string in hexidecimal or color name that sets the plot panel's border color.
#'   The default is "black". Set it to NA to eliminate the border rectangle entirely.
#' @param sf_color A string that sets the color attribute of the sf.
#' @param sf_fill A string that sets the fill color attribute of the sf.
#' @param sf_stroke A numeric that sets the drawing stroke width attribute for a sf point geometry.
#' @param sf_shape A numeric that sets the non-variable associated shape aesthetic.
#' @param sf_size A numeric value that sets the size attribute for scaling points.
#' @param sf_linewidth A numeric value that sets the line width of POLYGON, LINESTRING geometries.
#' @param sf_alpha A numeric value that sets the alpha level attribute of point and line geometries..
#' @param inherit_aes A logical which if FALSE the aesthetics are not combined with other overlapping geoms.
#' @param na_rm A logical which if TRUE, missing observations are removed. If FALSE, the default,
#'   missing observations are removed with a warning.
#' @param scale_breaks A string/numeric vector that defines the scale breaks.
#' @param scale_values A string/numeric vector that defines the possible values.
#' @param scale_limits A string/numeric vector that defines the scale limits.
#' @param scale_labels An optional string vector that defines the scale labels. Vector must be the same length
#' as \code{scale_breaks}.
#' @param scale_colors Vector of colors to use for n-color gradient.
#' @param scale_na_value A string that sets the color for missing values.
#' @param own_scale A logical which if TRUE, then your own scaling may be appended to the plot without using the above
#'   scale_* parameters.
#' @param show_legend A logical that controls the appearance of the legend.
#' @param legend_pos A string that sets the legend position. Acceptable values are
#'  "top", "bottom", "left", "right".
#' @param legend_key_width A numeric that sets the legend width in cm.
#' @param legend_key_height A numeric that sets the legend height in cm.
#' @param legend_key_backgrd A string that sets the legend's background color.
#'
#' @return A ggplot2 object
#'
#' @author Rick Dean
#'
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 geom_sf
#' @importFrom rlang sym
#'
#' @export
get_geom_sf <- function(
    sf,
    adding = FALSE,
    aes_color = NULL,
    aes_fill = NULL,
    aes_size = NULL,
    aes_text = NULL,
    text_size = 3.0,
    text_color = "black",
    text_fontface = "plain",
    text_check_overlap = FALSE,
    text_nudge_x = 0,
    text_nudge_y = 0,
    title = NULL,
    subtitle = NULL,
    caption = NULL,
    center_titles = FALSE,
    x_title = NULL,
    y_title = NULL,
    hide_x_tics = FALSE,
    hide_y_tics = FALSE,
    panel_color = "white",
    panel_border_color = "black",
    sf_color = "black",
    sf_fill = "gray",
    sf_stroke = 0.1,
    sf_shape = 21,
    sf_size = 0.1,
    sf_linewidth = 0.1,
    sf_alpha = 1.0,
    inherit_aes = TRUE,
    na_rm = FALSE,
    scale_breaks = waiver(),
    scale_values = NULL,
    scale_limits = NULL,
    scale_labels = NULL,
    scale_colors = heat.colors(8),
    scale_na_value = "gray50",
    own_scale = FALSE,
    show_legend = TRUE,
    legend_pos = "right",
    legend_key_width = 0.5,
    legend_key_height = 0.7,
    legend_key_backgrd = "white"
){
  if(!is.null(aes_fill)){
    aes_fill <- rlang::sym(aes_fill)
  }
  if(!is.null(aes_color)){
    aes_color <- rlang::sym(aes_color)
  }
  if(!is.null(aes_size)){
    aes_size <- rlang::sym(aes_size)
  }
  if(!is.null(aes_text)){
    aes_text <- rlang::sym(aes_text)
  }
  aplot <- NULL
  a_geom <- ggplot2::geom_sf(
    data = sf,
    fill = sf_fill,
    size = sf_size,
    shape = sf_shape,
    stroke = sf_stroke,
    linewidth = sf_linewidth,
    color = sf_color,
    alpha = sf_alpha,
    inherit.aes = inherit_aes,
    na.rm = na_rm
  )

  if(!adding){
    aplot <- ggplot2::ggplot() + a_geom
  }else {
    aplot <- a_geom
  }

  if(!is.null(aes_fill)){
    a_geom <- geom_sf(
      data = sf,
      aes(fill = !!aes_fill),
      size = sf_size,
      shape = sf_shape,
      stroke = sf_stroke,
      linewidth = sf_linewidth,
      color = sf_color,
      alpha = sf_alpha,
      inherit.aes = inherit_aes
    )

    if(adding){
      aplot <- a_geom
    }else {
      aplot <- aplot + a_geom
    }
  }

  if(!is.null(aes_color)){
    a_geom <- geom_sf(
      data = sf,
      aes(color = !!aes_color),
      size = sf_size,
      shape = sf_shape,
      stroke = sf_stroke,
      fill = sf_fill,
      linewidth = sf_linewidth,
      alpha = sf_alpha,
      inherit.aes = inherit_aes
    )

    if(adding){
      aplot <- a_geom
    }else {
      aplot <- aplot + a_geom
    }
  }

  if(!is.null(aes_size)){
    a_geom <- geom_sf(
      data = sf,
      aes(size = !!aes_size),
      shape = sf_shape,
      stroke = sf_stroke,
      color = sf_color,
      linewidth = sf_linewidth,
      fill = sf_fill,
      alpha = sf_alpha,
      inherit.aes = inherit_aes
    )

    if(adding){
      aplot <- a_geom
    }else {
      aplot <- aplot + a_geom
    }
  }

  if(!is.null(aes_text)){
    a_geom <- ggplot2::geom_sf_text(
      data = sf,
      aes(label = !!aes_text),
      color = text_color,
      size = text_size,
      fontface = text_fontface,
      check_overlap = text_check_overlap,
      nudge_x = text_nudge_x,
      nudge_y = text_nudge_y
    )
    if(adding){
      aplot <- a_geom
    }else {
      aplot <- aplot + a_geom
    }
  }

  if(adding){
    return(aplot)
  }else {
    # -------------------Additional ggplot2 components------------------------
    # ----------------------title and subtitle-----------------
    if(center_titles) {
      aplot <- aplot +
        theme(
          plot.title = element_text(hjust = .5, size = 20),
          plot.subtitle = element_text(hjust = .5, size = 14)
        )
    }else {
      aplot <- aplot +
        theme(
          plot.title = element_text(size = 20),
          plot.subtitle = element_text(size = 14)
        )
    }
    aplot <- aplot + labs(title = title, subtitle = subtitle, caption = caption)

    # --------------------panel and grids---------------------
    aplot <- aplot +
      theme(
        panel.background = element_rect(fill = panel_color, color = panel_border_color, size = 2)
      )

    # --------------------x/y axis titles------------------------
    if(is.null(x_title)) {
      aplot <- aplot +
        theme(
          axis.title.x = element_blank()
        )
    }else{
      aplot <- aplot +
        labs(x = x_title)
    }
    if(is.null(y_title)) {
      aplot <- aplot +
        theme(
          axis.title.y = element_blank()
        )
    }else{
      aplot <- aplot +
        labs(y = y_title)
    }

    # -----------------------hide x/y axis tics?----------------------
    if(hide_x_tics){
      aplot <- aplot +
        theme(
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank()
        )
    }
    if(hide_y_tics){
      aplot <- aplot +
        theme(
          axis.text.y = element_blank(),
          axis.ticks.y = element_blank()
        )
    }

    # -------------------scaling related parameters--------------------
    if(!own_scale){
      if(!is.null(aes_fill)) {
        if(is.factor(sf[[aes_fill]])){
          aplot <- aplot +
            ggplot2::scale_fill_manual(
              breaks = scale_breaks,
              values = scale_values,
              limits = scale_limits,
              labels = scale_labels,
              na.value = scale_na_value
            )
        }else{
          aplot <- aplot +
            ggplot2::scale_fill_gradientn(
              breaks = scale_breaks,
              limits = scale_limits,
              labels = scale_labels,
              colors = scale_colors,
              values = scale_values,
              na.value = scale_na_value
            )
        }
      }else if(!is.null(aes_color)){
        if(is.factor(sf[[aes_color]])){
          aplot <- aplot +
            ggplot2::scale_color_manual(
              breaks = scale_breaks,
              values = scale_values,
              limits = scale_limits,
              labels = scale_labels,
              na.value = scale_na_value
            )
        }else{
          aplot <- aplot +
            ggplot2::scale_color_gradientn(
              breaks = scale_breaks,
              limits = scale_limits,
              labels = scale_labels,
              colors = scale_colors,
              values = scale_values,
              na.value = scale_na_value
            )
        }
      }else if(!is.null(aes_size)){
        if(is.factor(sf[[aes_size]])){
          aplot <- aplot +
            ggplot2::scale_size_manual(
              breaks = scale_breaks,
              values = scale_values,
              limits = scale_limits,
              labels = scale_labels,
              na.value = scale_na_value
            )
        }else{
          aplot <- aplot +
            ggplot2::scale_size(
              breaks = scale_breaks,
              limits = scale_limits,
              labels = scale_labels
            )
        }
      }
    }

    # -------------------legend related parameters---------------------------
    if(!show_legend){
      aplot <- aplot +
        theme(legend.position = "none")
    }else {
      aplot <- aplot +
        theme(
          legend.position = legend_pos,
        legend.key = element_rect(fill = legend_key_backgrd),
        legend.key.width = unit(legend_key_width, "cm"),
        legend.key.height = unit(legend_key_height, "cm")
      )
    }

    return(aplot)
  }
}
