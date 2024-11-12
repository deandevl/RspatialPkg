#' matrix_to_sf
#'
#' Function converts a matrix of long/lat coordinate(s) into a simple features
#' object (sf::sf)
#'
#' The submitted matrix of longitude (column 1) and latitude (column 2)
#'  coordinate(s) is converted into an sf object. See \href{https://r-spatial.github.io/sf/articles/sf1.html}{Simple Features for R}
#'  for more information on simple features.
#'
#' @param a_matrix A matrix describing the point/polygon geometry.
#' @param xy_v A two element vector that defines the columns of \code{a_matrix} for the x/y coordinates.
#'   Values can be the column names of the matrix or column index numbers.
#' @param crs Defines the coordinate reference system to use. Can be an integer with the EPSG code or character with proj4 string.
#'   Default is EPSG value 4326.
#'
#' @importFrom sf st_as_sf
#' @importFrom sf st_crs
#'
#' @return An sf::sf object
#'
#' @author Rick Dean
#'
#' @export
matrix_to_sf <- function(
  a_matrix = NULL,
  xy_v = NULL,
  crs = sf::st_crs(4326)){
  coords_df <- as.data.frame(a_matrix)
  coords_sf <- sf::st_as_sf(coords_df, coords = c(xy_v[[1]], xy_v[[2]]), crs = crs)
  return(coords_sf)
}
