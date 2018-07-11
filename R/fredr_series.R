#' Fetch a FRED series
#'
#' Given a series ID, return observations of that series as a `tibble` object.
#'
#' @param series_id A string ID for the FRED series. Use [fredr_search()]
#'        to find the `series_id` of a series.
#' @param options Extra options defined by [fredr_options()].
#'
#' @return A \code{tibble} object with observation dates and values.
#'
#' @section Optional Parameters:
#'
#' * `observation_start`
#' * `observation_end`
#' * `frequency`
#' * `aggregation_method`
#' * `limit`
#' * `offset`
#' * `sort_order`
#' * `units`
#' * `realtime_start`
#' * `realtime_end`
#' * `vintage_dates`
#' * `output_type`
#'
#' @section API Documentation:
#'
#' [fred/series/observations](https://research.stlouisfed.org/docs/api/fred/series_observations.html)
#'
#' @examples
#' fredr_series(
#'   series_id = "UNRATE",
#'   options = fredr_options(
#'     observation_start = as.Date("1980-01-01"),
#'     observation_end = as.Date("2000-01-01"),
#'     unit = "chg"
#'   )
#' )
#'
#' fredr_series(
#'   series_id = "OILPRICE",
#'   options = fredr_options(
#'     frequency = "q",
#'     aggregation_method = "avg",
#'     unit = "log"
#'   )
#' )
#'
#' @export
#'
fredr_series <- function(series_id, options = fredr_options()) {

  validate_series_id(series_id)

  fredr_args <- list(
    series_id = series_id,
    endpoint = "series/observations"
  )

  frame <- do.call(fredr, c(fredr_args, options))

  frame$value[frame$value == "."] <- NA
  frame$value <- as.numeric(frame$value)
  frame$date <- as.Date(frame$date, "%Y-%m-%d")

  frame <- frame[order(frame$date), c("date", "value")]

  names(frame) <- c("date", series_id)

  return(frame)
}
