#' Fetch a FRED series
#'
#' Given a series ID, return observations of that series as \code{tibble} object.
#'
#' @param series_id A string ID for the FRED series.  Use \code{\link{fredr_search}}
#'        to find the \code{series_id} of a series.
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
#' Defaults to `lin`. Possible values are:
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
#' @section API Docs:
#'
#' [fred/series/observations](https://research.stlouisfed.org/docs/api/fred/series_observations.html)
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
#'
#'
fredr_series <- function(series_id,
                         observation_start = NULL,
                         observation_end = NULL,
                         frequency = NULL,
                         aggregation_method = "avg",
                         limit = 100000L,
                         offset = 0,
                         sort_order = "asc",
                         units = "lin",
                         realtime_start = NULL,
                         realtime_end = NULL,
                         vintage_dates = NULL,
                         output_type = 1
                         ) {

  args <- capture_fred_args(
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

  if(is.null(series_id)) {
    stop("Argument `series_id` must be supplied.", call. = FALSE)
  }

  fredr_args <- list(endpoint = "series/observations", to_frame = TRUE)

  frame <- do.call(fredr, c(fredr_args, args))

  frame$value[frame$value == "."] <- NA
  frame$value <- as.numeric(frame$value)
  frame$date <- as.Date(frame$date, "%Y-%m-%d")

  frame <- frame[order(frame$date), c("date", "value")]

  names(frame) <- c("date", series_id)

  return(frame)
}


capture_fred_args <- function(...) {
  args <- list(...)

  # Validation - series
  validate_series_id(args$series_id)

  # Validation - search

  # Validation - dates
  validate_is_date(args$observation_start, "observation_start")
  validate_is_date(args$observation_end, "observation_end")
  validate_is_date(args$realtime_start, "realtime_start")
  validate_is_date(args$realtime_end, "realtime_end")
  validate_is_date(args$vintage_dates, "vintage_dates")

  # Date formatting
  args$observation_start <- format_fred_date(args$observation_start)
  args$observation_end   <- format_fred_date(args$observation_end)
  args$realtime_start    <- format_fred_date(args$realtime_start)
  args$realtime_end      <- format_fred_date(args$realtime_end)
  args$vintage_dates     <- format_fred_date(args$vintage_dates)

  args
}

format_fred_date <- function(x) {
  if(is.null(x)) {
    return(x)
  }

  format(x, "%Y-%m-%d")
}
