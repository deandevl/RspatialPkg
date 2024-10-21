#' dot_density_sf
#'
#' The function returns a special feature object (class \code{sf}) from the submitted simple feature object
#'   that has \code{POINT} geometries (called a "dot")
#'   representing each observation (or counts of observations) of the feature object.
#'
#'  The functions \code{terra::vect()} and \code{terra::dots()} are used in creating the dots
#'  and can be used to make a dot-density map.
#'
#'  See \href{https://rspatial.github.io/terra/reference/dots.html}{Make a dot-density map}
#'    for more information and example on dot-density maps.
#'
#' @param sf A simple features object of class "sf".
#' @param dot_col The variabe name from \code{sf} that represents the dots
#' @param cases_per_dot A numeric that sets the number of cases represented by each dot
#' @param group_col The variabe name from \code{sf} that represents the cases into distinct groups
#'
#' @return A \code{sf} object with geometry type \code{POINT}. If the
#' the cases are grouped, then a feature is added to \code{sf} that represents the fraction of dots for each group
#'
#' @author Rick Dean
#'
#' @importFrom terra vect
#' @importFrom terra dots
#' @importFrom purrr map_dfr
#' @importFrom sf st_as_sf
#' @importFrom sf st_filter
#' @importFrom data.table as.data.table
#'
#' @export
dot_density_sf <- function(
  sf = NULL,
  dot_col = NULL,
  cases_per_dot = NULL,
  group_col = NULL
){
  # Are we grouping?
  if(!is.null(group_col)){
    groups_v <- unique(sf[[group_col]])
    dt <- data.table::as.data.table(sf)
    func <- function(g){
      g_data <- dt[dt[[group_col]] == g, ]
      g_data_sf <- sf::st_as_sf(g_data)
      g_spa_v <- terra::vect(g_data_sf)
      g_dots_spa_v <- terra::dots(
        g_spa_v,
        field = dot_col,
        size = cases_per_dot
      )
      g_dots_sf <- sf::st_as_sf(g_dots_spa_v)
      return(g_dots_sf)
    }
    dots_sf <- purrr::map_dfr(groups_v, func)
  }else {
    sf_spa_v <- terra::vect(sf)
    dots_spa_v <- terra::dots(
      x = sf_spa_v,
      field = dot_col,
      size = cases_per_dot
    )
    dots_sf <- sf::st_as_sf(dots_spa_v)
  }
  return(dots_sf)
}
