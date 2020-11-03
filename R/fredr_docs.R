#' Open the web documentation for a certain FRED API topic.
#'
#' Opens FRED API web documentation in a new web browser tab.
#'
#' @section API Documentation:
#'
#' [FRED API](https://fred.stlouisfed.org/docs/api/fred/)
#'
#' @examples
#' if (interactive()) {
#' fredr_docs()
#' }
#' @export
fredr_docs <- function() {
  utils::browseURL(url = "https://fred.stlouisfed.org/docs/api/fred/")
}
