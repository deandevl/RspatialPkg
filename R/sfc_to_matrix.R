#' sfc_to_matrix
#'
#' Function converts point geometries from an sf::sfc object to matrix form
#'
#' @param x An 'sfc' object
#'
#' @return A numeric matrix of the point coordinates from an sf::sfc object.
#'
#' @author Rick Dean
#'
#' @export
sfc_to_matrix <- function(x){
  x_lst <- unlist(x, use.names = FALSE)
  n_row <- length(x_lst)/2

  matrix(
    x_lst,
    nrow = n_row
  )
}
