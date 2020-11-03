#' Get observations of a FRED series
#'
#' Given a series ID, return observations of that series as a `tibble` object.
#' `fredr()` is an alias for `fredr_series_observations()`.
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
#' Possible values are: `"asc"` (default), and `"desc"`.
#'
#' @param units A string indicating the data value transformation.
#' Defaults to `"lin"`. Possible values are:
#'
#' * `"lin"` - Levels (No transformation)
#' * `"chg"` - Change
#' * `"ch1"` - Change from 1 year ago
#' * `"pch"` - Percent change
#' * `"pc1"` - Percent change from 1 year ago
#' * `"pca"` - Compounded annual rate of change
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
#' @param output_type An integer indicating the output type. Not used unless
#' `realtime_start` is used. Possible values are:
#'
#' * `1` for Observations by Real-Time Period (default)
#' * `2` for Observations by Vintage Date, All Observations
#' * `3` for Observations by Vintage Date, New and Revised Observations Only
#' * `4` for Observations, Initial Release Only.
#'
#' @param ... These dots only exist for future extensions and should be empty.
#'
#' @return A `tibble` object with observation dates and values.
#'
#' @section API Documentation:
#'
#' [fred/series/observations](https://research.stlouisfed.org/docs/api/fred/series_observations.html)
#'
#' @seealso [fredr_series_search_text()],
#' [fredr_series_search_id()], [fredr_series_search_tags()],
#' [fredr_series_search_related_tags()], [fredr_series()], [fredr_series_categories()],
#' [fredr_series_release()], [fredr_series_tags()], [fredr_series_updates()],
#' [fredr_series_vintagedates()].
#'
#' @examples
#' if (fredr_has_key()) {
#' # Observations for "UNRATE" series between 1980 and 2000.  Units are in terms
#' # of change from previous observation.
#' fredr(
#'   series_id = "UNRATE",
#'   observation_start = as.Date("1980-01-01"),
#'   observation_end = as.Date("2000-01-01"),
#'   units = "chg"
#' )
#' # All observations for "OILPRICE" series.  The data is first aggregated by
#' # quarter by taking the average of all observations in the quarter then
#' # transformed by taking the natural logarithm.
#' fredr(
#'   series_id = "OILPRICE",
#'   frequency = "q",
#'   aggregation_method = "avg",
#'   units = "log"
#' )
#'
#' # To retrieve values for multiple series, use purrr's map_dfr() function.
#'
#' if (requireNamespace("purrr", quietly = TRUE)) {
#'
#'   library(purrr)
#'   purrr::map_dfr(c("UNRATE", "OILPRICE"), fredr)
#'
#'   # Using purrr::pmap_dfr() allows you to use varying optional parameters
#'   params <- list(
#'     series_id = c("UNRATE", "OILPRICE"),
#'     frequency = c("m", "q")
#'   )
#'
#'   purrr::pmap_dfr(
#'     .l = params,
#'     .f = ~ fredr(series_id = .x, frequency = .y)
#'   )
#'
#' }
#'
#' }
#' @rdname fredr
#' @export
fredr_series_observations <- function(series_id,
                                      ...,
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
  check_dots_empty(...)
  check_not_null(series_id, "series_id")

  user_args <- capture_args(
    series_id = series_id,
    observation_start = observation_start,
    observation_end = observation_end,
    frequency = frequency,
    aggregation_method = aggregation_method,
    limit = limit,
    offset = offset,
    sort_order = sort_order,
    units = units,
    realtime_start = realtime_start,
    realtime_end = realtime_end,
    vintage_dates = vintage_dates,
    output_type = output_type
  )

  fredr_args <- list(
    endpoint = "series/observations"
  )

  frame <- do.call(fredr_request, c(fredr_args, user_args))

  if(NROW(frame) == 0) {
    return(empty_fredr_tibble())
  }

  frame$value[frame$value == "."] <- NA

  obs <- tibble::tibble(
    date = as.Date(frame$date, "%Y-%m-%d"),
    series_id = series_id,
    value = as.numeric(frame$value)
  )

  obs
}

#' @rdname fredr
#' @export
fredr <- fredr_series_observations


empty_fredr_tibble <- function() {

  zero_length_numeric <- numeric()

  zero_length_date <- zero_length_numeric
  class(zero_length_date) <- "Date"

  zero_length_character <- character()

  tibble::tibble(
    date = zero_length_date,
    series_id = zero_length_character,
    value = zero_length_numeric
  )
}
