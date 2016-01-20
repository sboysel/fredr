#' Send a request to the FRED API server
#'
#' @param endpoint A string representing the FRED API path of interest. See
#'        https://api.stlouisfed.org/docs/fred/.
#' @param ... A series of paramters to be used in the query.  Of the form
#'        param_key = 'param_value'.  Acceptable parameters are specific to
#'        the API path.  See https://api.stlouisfed.org/docs/fred/.
#' @param to_frame A boolean value indicating whether or not the response
#'        should be parsed and formatted as a tbl_df.  Default is TRUE.
#' @param print_req A boolean value indicating whether or not the request
#'        should be printed as well.  Useful for debugging.
#' @return A tbl_df.  If to_frame is TRUE, return is a reponse object from 
#'        httr::GET().
#' @examples
#'  fredr("series/observations",
#'        series_id = "GNPCA",
#'        observation_start = "1990-01-01",
#'        observation_end = "2000-01-01")
#' @export
fredr <- function(endpoint, ..., to_frame = TRUE, print_req = FALSE) {
  params <- list(...)
  if (identical(Sys.getenv("FRED_API_KEY"), "")) {
    stop("FRED API key must be set.  Use fredr_key()")
  }
  params$api_key <- Sys.getenv("FRED_API_KEY")
  params$file_type <- "json"
  resp <- httr::GET(url = "https://api.stlouisfed.org/",
                    path = paste0("fred/", endpoint),
                    query = params)
  if (print_req == TRUE) {
    message(resp$url)
  }
  if (resp$status_code != 200) {
    err <- httr::content(resp)
    stop(paste0(err$error_code, ": ", err$error_message))
  }
  if (to_frame == TRUE) {
    parsed <- httr::content(resp)
    if (endpoint %in% c("category",
                        "category/children",
                        "category/related",
                        "series/categories")) {
      frame <- dplyr::bind_rows(parsed$categories)
    }
    if (endpoint == "category/series") {
        frame <- dplyr::bind_rows(parsed$series)
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
        frame <- dplyr::bind_rows(parsed$tags)
    }
    if (endpoint %in% c("releases",
                        "release",
                        "series/release",
                        "source/releases")) {
      frame <- dplyr::bind_rows(parsed$releases)
    }
    if (endpoint %in% c("releases/dates",
                        "release/dates")) {
      frame <- dplyr::bind_rows(parsed$release_dates)
    }
    if (endpoint %in% c("release/series",
                        "series",
                        "series/search",
                        "series/updates",
                        "tags/series")) {
      frame <- dplyr::bind_rows(parsed$seriess)
    }
    if (endpoint == "release/sources") {
      frame <- dplyr::bind_rows(parsed$sources)
    }
    if (endpoint == "series/observations") {
      frame <- dplyr::bind_rows(parsed$observations)
    }
    if (endpoint == "series/vintagedates") {
      frame <- unlist(parsed$vintage_dates)
    }
    if (endpoint %in% c("source",
                        "sources")) {
      frame <- dplyr::bind_rows(parsed$sources)
    }
    return(frame)
  } else {
    return(resp)
  }
}
