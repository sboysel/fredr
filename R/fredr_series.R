#' Fetch a FRED series
#'
#' Given a series ID, return observations of that series as \code{tibble} object.
#'
#' @param series_id A string ID for the FRED series.  Use \code{\link{fredr_search}}
#'        to find the \code{series_id} of a series.
#' @param ... A series of named parameters to be used in the query.  Must be of the form
#'        \code{param_key = "param_value"}.  Acceptable parameters are endpoint-specific.
#'        See  \code{\link{fredr_endpoints}} for a list of endpoints and \code{\link{fredr_docs}}
#'        access to the endpoint web documentation.
#'
#' @return A \code{tibble} object with observation dates and values.
#'
#' @examples
#' fredr_series(
#'   series_id = "UNRATE",
#'   observation_start = "1980-01-01",
#'   observation_end = "2000-01-01",
#'   unit = "chg"
#' )
#'
#' fredr_series(
#'   series_id = "OILPRICE",
#'   frequency = "q",
#'   aggregation_method = "avg",
#'   unit = "log"
#' )
#' @export
fredr_series <- function(series_id, ...) {

  stopifnot(is.character(series_id), length(series_id) == 1)

  frame <- fredr::fredr(
    endpoint = "series/observations",
    series_id = series_id,
    to_frame = TRUE,
    ...
  )

  frame$value[frame$value == "."] <- NA
  frame$value <- as.numeric(frame$value)
  frame$date <- as.Date(frame$date, "%Y-%m-%d")

  frame <- frame[order(frame$date), c("date", "value")]

  names(frame) <- c("date", series_id)

  return(frame)
}
