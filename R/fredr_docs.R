#' Open the web documentation for a certain FRED API topic.
#'
#' Opens FRED API web documentation in a new browser tab.
#'
#' @param endpoint A string representing the desired documentation for the exact
#'				FRED API endpoint.  Default is \code{"base"}, which will open a link to
#'				\url{https://api.stlouisfed.org/docs/fred/}.
#' @param params A boolean value.  If \code{TRUE}, the documentation will be opened at
#'        the 'Parameters' section.  Default is \code{FALSE}.
#' @param debug A boolean value.  If \code{TRUE}, the documentation is not opened in a
#'        browser.  Default is \code{FALSE}.
#'
#' @references See \url{https://api.stlouisfed.org/docs/fred/}.
#'
#' @examples
#' \dontrun{
#' fredr_docs()
#' fredr_docs('category')
#' fredr_docs('series/observations')
#' fredr_docs('series/observations', params = TRUE)
#' }
#' @export
fredr_docs <- function(endpoint = "base", params = FALSE, debug = FALSE) {

  stopifnot(length(endpoint) == 1, is.character(endpoint))

  base <- "https://api.stlouisfed.org/docs/fred/"

  if (endpoint == "base" & !debug) {
    utils::browseURL(url = doc)
  } else {

    doc <- paste0(base, gsub("/", "_", endpoint), ".html")

    if (!identical(httr::status_code(httr::GET(url = doc)), 200L)) {
      stop(paste("Bad endpoint:", doc))
    }

    if (params) {
      doc <- paste0(doc, "#Parameters")
    }

    if (!debug) {
      utils::browseURL(url = doc)
    }

  }

}
