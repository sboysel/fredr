#' Fetch observations of a FRED series
#'
#' Given a series ID, return observations of that series as a `tibble` object.
#'
#' @param series_id A string ID for the FRED series.
#'
#' @param observation_start A `Date` indicating the start of the observation period.
#' Defaults to `1776-07-04`, the earliest available date.
#'
#' @param observation_end A `Date` indicating the end of the observation period.
#' Defaults to `9999-12-31`, the latest available date.
#'
#' @param frequency A string representing a lower frequency to aggregate to.
#' Defaults to no frequency aggregation. Possible values are:
#'
#' * `"d"` - Daily
#' * `"w"` - Weekly
#' * `"bw"` - Biweekly
#' * `"m"` - Monthly
#' * `"q"` - Quarterly
#' * `"sa"` - Semiannual
#' * `"a"` - Annual
#' * `"wem"` - Weekly, ending Monday
#' * `"wetu"` - Weekly, ending Tuesday
#' * `"wew"` - Weekly, ending Wednesday
#' * `"weth"` - Weekly, ending Thursday
#' * `"wef"` - Weekly, ending Friday
#' * `"wesa"` - Weekly, ending Saturday
#' * `"wesu"` - Weekly, ending Sunday
#' * `"bwew"` - Biweekly, ending Wednesday
#' * `"bwem"` - Biweekly, ending Monday
#'
#' @param aggregation_method A string representing the aggregation method
#' used for frequency aggregation. This parameter has no affect is `frequency`
#' is not set. Possible values are:
#'
#' * `"avg"` for average
#' * `"sum"` for sum
#' * `"eop"` for end of period value
#'
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `100000`, the maximum.
#'
#' @param offset An integer used in conjunction with `limit` for long series.
#' This mimics the idea of _pagination_ to retrieve large amounts of data over
#' multiple calls. Defaults to `0`.
#'
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"`, and `"desc"`. Defaults to `"asc"`.
#'
#' @param units A string indicating the data value transformation.
#' Defaults to `"lin"`. Possible values are:
#'
#' * `"lin"` - Levels (No transformation)
#' * `"chg"` - Change
#' * `"ch1"` - Change from 1 year ago
#' * `"pch"` - Percent change
#' * `"pc1"` - Percent change from 1 year ago
#' * `"pca"` - Counpounded annual rate of change
#' * `"cch"` - Continuously compounded rate of change
#' * `"cca"` - Continuously compounded annual rate of change
#' * `"log"` - Natural log
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param vintage_dates A vector of `Date` objects to download data for.
#' Vintage dates are used to download data as it existed on these specified
#' dates in history. They can be specified instead of a real-time period using
#' `realtime_start` and `realtime_end`. Defaults to no vintage dates.
#'
#' @param output_type An integer indicating the output type. Defaults to `1`
#' but is not used unless `realtime_start` is used. Possible values
#' are:
#'
#' * `1` for Observations by Real-Time Period
#' * `2` for Observations by Vintage Date, All Observations
#' * `3` for Observations by Vintage Date, New and Revised Observations Only
#' * `4` for Observations, Initial Release Only.
#'
#' @return A \code{tibble} object with observation dates and values.
#'
#' @section API Documentation:
#'
#' [fred/series/observations](https://research.stlouisfed.org/docs/api/fred/series_observations.html)
#'
#' @examples
#' fredr_series_observations(
#'   series_id = "UNRATE",
#'   observation_start = as.Date("1980-01-01"),
#'   observation_end = as.Date("2000-01-01"),
#'   unit = "chg"
#' )
#'
#' fredr_series_observations(
#'   series_id = "OILPRICE",
#'   frequency = "q",
#'   aggregation_method = "avg",
#'   unit = "log"
#' )
#'
#' @export
fredr_series_observations <- function(series_id = NULL,
                                      observation_start = NULL,
                                      observation_end = NULL,
                                      frequency = NULL,
                                      aggregation_method = NULL,
                                      limit = NULL,
                                      offset = NULL,
                                      sort_order = NULL,
                                      units = NULL,
                                      realtime_start = NULL,
                                      realtime_end = NULL,
                                      vintage_dates = NULL,
                                      output_type = NULL) {

  validate_series_id(series_id)

  user_args <- capture_args(
    observation_start,
    observation_end,
    frequency,
    aggregation_method,
    limit,
    offset,
    sort_order,
    units,
    realtime_start,
    realtime_end,
    vintage_dates,
    output_type
  )

  fredr_args <- list(
    series_id = series_id,
    endpoint = "series/observations"
  )

  frame <- do.call(fredr, c(fredr_args, user_args))

  frame$value[frame$value == "."] <- NA
  frame$value <- as.numeric(frame$value)
  frame$date <- as.Date(frame$date, "%Y-%m-%d")

  frame <- frame[order(frame$date), c("date", "value")]

  names(frame) <- c("date", series_id)

  return(frame)
}

validate_series_id <- function(x) {
  if(is.null(x)) {
    stop("Argument `series_id` must be supplied.", call. = FALSE)
  }

  validate_is_class(x, "series_id", "character")

  if(! (length(x) == 1) ) {
    stop("Argument `series_id` must be of length 1.", call. = FALSE)
  }
}
