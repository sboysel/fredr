#' Return a FRED dataset as an \code{xts} object.
#'
#' @param ... A series of paramters to be used in the query.  Of the form
#'        param_key = 'param_value'.  The parameter \code{series_id} is
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
fredr_series <- function(...) {

  params <- list(...)

  if (!("series_id" %in% names(params))) {
    stop("Missing 'series_id' parameter.")
  }

  frame <- fredr::fredr(endpoint = "series/observations", ...)

  frame$value[frame$value == "."] <- NA
  frame$value <- as.numeric(frame$value)
  frame$date <- as.Date(frame$date, "%Y-%m-%d")

  frame <- frame[order(frame$date), ]

  series <- xts::xts(
    x = frame$value,
    order.by = frame$date
  )

  names(series) <- params[["series_id"]]

  return(series)
}
