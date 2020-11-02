#' Send a request to the FRED API
#'
#' Send a general request to the FRED API by specifying an endpoint and a
#' sequence of parameters.  The `fredr_request()` function forms and submits a
#' request to a specified endpoint of the FRED API.  The result is either the
#' `response` object from [httr::GET()] or the response parsed as a `tibble`.
#'
#' @param endpoint A string representing the FRED API endpoint of interest. See
#'   [fredr_endpoints] for a list of endpoint possible values. _Required
#'   parameter._
#' @param ... A series of named parameters to be used in the query.  Must be of
#'   the form `param_key = "param_value"`.  Acceptable parameters are
#'   endpoint-specific. See the [fredr_endpoints] data frame for a list of
#'   endpoints and [fredr_docs()] to access the web documentation for each
#'   endpoint function.
#' @param to_frame A boolean value indicating whether or not the response should
#'   be parsed and formatted as a data frame.  If `FALSE`, a `response` object
#'   is returned and further processing can be done with [httr::content()].
#'   Default is `TRUE`.
#' @param print_req A boolean value indicating whether or not the request should
#'   be printed as well.  Useful for debugging.  Default is `FALSE`.
#' @param retry_times An integer indicating the maximum number of requests to
#'   attempt. Passed directly to [httr::RETRY()].  Default is 3.
#' @return If `to_frame = TRUE`, a `tibble` containing the parsed response. If
#'   `to_frame = FALSE`, a `response` object returned directly from
#'   [httr::GET()].
#'
#' @section API Documentation:
#'
#'   [FRED API](https://api.stlouisfed.org/docs/fred/)
#'
#' @examples
#' \donttest{
#' fredr_request(
#'   endpoint = "series/observations",
#'   series_id = "GNPCA",
#'   observation_start = "1990-01-01",
#'   observation_end = "2000-01-01"
#' )
#'
#' # Compare to to_frame = `FALSE`
#' resp <- fredr_request(
#'   endpoint = "series/observations",
#'   series_id = "GNPCA",
#'   observation_start = "1990-01-01",
#'   observation_end = "2000-01-01",
#'   to_frame = FALSE
#' )
#' }
#' @export
fredr_request <- function(endpoint,
                          ...,
                          to_frame = TRUE,
                          print_req = FALSE,
                          retry_times = 3L) {

  if (is_null(fredr_get_key())) {
    stop("FRED API key must be set. See `?fredr_set_key`.")
  }

  validate_endpoint(endpoint)

  params <- list(...)
  params$api_key <- fredr_get_key()
  params$file_type <- "json"

  resp <- httr::RETRY(
    verb = "GET",
    url = "https://api.stlouisfed.org/",
    path = paste0("fred/", endpoint),
    query = params,
    times = retry_times
  )

  if (print_req) {
    message(resp$url)
  }

  if (resp$status_code != 200) {
    err <- httr::content(resp)
    stop(paste0(err$error_code, ": ", err$error_message))
  }

  if (to_frame) {
    parsed <- jsonlite::fromJSON(httr::content(resp, "text"))
    if (endpoint %in% c("category",
                        "category/children",
                        "category/related",
                        "series/categories")) {
      frame <- tibble::as_tibble(parsed$categories)
    }
    if (endpoint == "category/series") {
      frame <- tibble::as_tibble(parsed$series)
    }
    if (endpoint %in% c("category/tags",
                        "category/related_tags",
                        "release/tags",
                        "release/related_tags",
                        "series/search/tags",
                        "series/search/related_tags",
                        "series/tags",
                        "tags",
                        "related_tags")) {
      frame <- tibble::as_tibble(parsed$tags)
    }
    if (endpoint %in% c("releases",
                        "release",
                        "series/release",
                        "source/releases")) {
      frame <- tibble::as_tibble(parsed$releases)
    }
    if (endpoint %in% c("releases/dates",
                        "release/dates")) {
      frame <- tibble::as_tibble(parsed$release_dates)
    }
    if (endpoint %in% c("release/series",
                        "series",
                        "series/search",
                        "series/updates",
                        "tags/series")) {
      frame <- tibble::as_tibble(parsed$seriess)
    }
    if (endpoint == "release/sources") {
      frame <- tibble::as_tibble(parsed$sources)
    }
    if (endpoint == "series/observations") {
      frame <- tibble::as_tibble(parsed$observations)
    }
    if (endpoint == "series/vintagedates") {
      frame <- tibble::tibble(vintage_dates = parsed$vintage_dates)
    }
    if (endpoint %in% c("source",
                        "sources")) {
      frame <- tibble::as_tibble(parsed$sources)
    }
    if (endpoint == "release/tables") {
      frame <- tibble::enframe(parsed$elements)
    }
    return(frame)
  } else {
    return(resp)
  }
}
