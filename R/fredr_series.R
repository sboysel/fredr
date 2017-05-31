#' Return a FRED dataset as an \code{xts} object.
#'
#' @param series_id A string ID for the FRED series
#' @param ... Additional parameters passed directly to API.  Must be of the
#'        form \code{param_key = 'param_value'}.
#'        required.
#' @return An \code{xts} object.
#' @examples
#' fredr_series(series_id = "UNRATE",
#'              observation_start = "1980-01-01",
#'              observation_end = "2000-01-01",
#'              unit = "chg")
#' fredr_series(series_id = "OILPRICE",
#'              frequency = "q",
#'              aggregation_method = "avg",
#'              unit = "log")
#' @export
fredr_series <- function(series_id, ...) {

  stopifnot(is.character(series_id), length(series_id) == 1)

  frame <- fredr::fredr(endpoint = "series/observations", series_id = series_id, ...)

  frame$value[frame$value == "."] <- NA
  frame$value <- as.numeric(frame$value)
  frame$date <- as.Date(frame$date, "%Y-%m-%d")

  frame <- frame[order(frame$date), ]

  series <- xts::xts(
    x = frame$value,
    order.by = frame$date
  )

  names(series) <- series_id

  return(series)
}
