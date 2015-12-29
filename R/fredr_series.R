# -----------------------------------------------------------------------------
# Return a FRED dataset as a time series object.
# -----------------------------------------------------------------------------
#' Return a FRED dataset as a time series object.
#'
#' @param ... A series of paramters to be used in the query.  Of the form
#'        param_key = 'param_value'.  The parameter \code{series_id} is
#'        required.
#' @return A \code{ts} object.
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
  if ("frequency" %in% names(params)) {
    freq <- switch(params[["frequency"]],
                 "d" = 365,
                 "w" = 52,
                 "bw" = 26,
                 "m" = 12,
                 "q" = 4,
                 "sq" = 2,
                 "a" = 1)
    if (is.null(freq)) {
      stop("Invalid 'frequency' value supplied.")
    }
  } else {
    freq <- switch(fredr::get_freq(params[["series_id"]]),
                   "Daily" = 365,
                   "Weekly" = 52,
                   "Bi-Weekly" = 26,
                   "Monthly" = 12,
                   "Quarterly" = 4,
                   "Semiannual" = 2,
                   "Annual" = 1)
  }
  frame <- fredr::fredr(endpoint = "series/observations", ...)
  frame$value <- as.numeric(frame$value)
  frame$date <- as.Date(frame$date, "%Y-%m-%d")
  y <- as.numeric(format(frame$date[1], "%Y"))
  m <- as.numeric(format(frame$date[1], "%m"))
  d <- as.numeric(format(frame$date[1], "%d"))
  series <- ts(data = frame$value,
               start = c(y, m, d),
               frequency = freq)
  return(series)
}

#' Check the default frequency of a series with a call to the FRED API
#'
#' @param series_id A string
#' @return An integer representing the number of series observations in a unit 
#'         of time.  Used in creating a \code{ts} object with the appropriate 
#'         temporal frequency.
#' @examples
#'  get_freq(series_id = "GNPCA")
#' @export
get_freq <- function(series_id){
  if (is.null(series_id)) {
    stop("series_id parameter not present.")
  }
  freq <- fredr::fredr("series", series_id = series_id)$frequency
  return(freq)
}
