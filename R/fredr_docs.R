#' Open the web documentation for a certain FRED API topic.
#'
#' Opens FRED API web documentation in a new web browser tab.
#'
#' @section API Documentation:
#'
#' [FRED API](https://api.stlouisfed.org/docs/fred/)
#'
#' @examples
#' fredr_docs()
#' @export
fredr_docs <- function() {
  utils::browseURL(url = "https://api.stlouisfed.org/docs/fred/")
}
