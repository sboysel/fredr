#' Open the web documentation for a certain FRED API topic.
#'
#' Opens FRED API web documentation in a new browser tab.
#'
#' @param endpoint A string representing the desired documentation for the exact
#'				FRED API endpoint.  Default is `"base"`, which will open a link to
#'				\url{https://api.stlouisfed.org/docs/fred/}.
#' @param params A boolean value.  If `TRUE`, the documentation will be opened at
#'        the "Parameters" section.  Default is `FALSE`.
#' @param debug A boolean value.  If `TRUE`, the documentation is not opened in a
#'        browser and the documentation URL is returned as a string.  If `FALSE`,
#'        documentation is opened in a browser and nothing is returned.  Default
#'        is `FALSE`.
#'
#' @section API Documentation:
#'
#' [FRED API](https://api.stlouisfed.org/docs/fred/)
#'
#' @examples
#' \dontrun{
#' fredr_docs()
#' fredr_docs(endpoint = "category")
#' fredr_docs(endpoint = "series/observations")
#' fredr_docs(endpoint = "series/observations", params = TRUE)
#' }
#' @export
fredr_docs <- function(endpoint = "base", params = FALSE, debug = FALSE) {

  stopifnot(length(endpoint) == 1, is.character(endpoint))

  if (identical(endpoint, "base") & params) {
    stop("params cannot be set to TRUE with the 'base' endpoint")
  }

  url <- "https://api.stlouisfed.org/docs/fred/"

  if (!identical(endpoint, "base")) {
    url <- paste0(url, gsub("/", "_", endpoint), ".html")
  }

  if (params) {
    url <- paste0(url, "#Parameters")
  }

  if (debug) {
    url
  } else {

    resp <- httr::status_code(httr::GET(url = url))

    if (!identical(resp, 200L)) {
      stop(paste("Bad endpoint:", url))
    } else {
      utils::browseURL(url = url)
    }

  }

}
