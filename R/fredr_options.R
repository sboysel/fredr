#' Optional parameters used in FRED API calls
#'
#' This helper function describes all possible API parameters for FRED. Only
#' a select subset of them are allowed for a specific function, so see the
#' `Optional Parameter` section of each function to learn which ones are
#' allowed.
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
#' Defaults to the maximum value for the endpoint. Consult the API documentation
#' of your endpoint for specific information.
#'
#' @param offset An integer used in conjunction with `limit` for long series.
#' This mimics the idea of _pagination_ to retrieve large amounts of data over
#' multiple calls. Defaults to `0`.
#'
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"`, and `"desc"`. Generally defaults to `"asc"`.
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
#' @param tag_names A semicolon delimited string of tag names.
#' Note that this value must be a valid FRED series tag
#' (e.g. `"30-year"`, `"usa"`, `"quarterly"`, etc.).
#'
#' @param exclude_tag_names A semicolon delimited string of tag names used to
#' exclude results with.
#'
#' @param tag_group_id A tag group id to filter tags by type. No filtering by
#' tag group by default. Possible values are:
#'
#' * `freq` = Frequency
#' * `gen` = General or Concept
#' * `geo` = Geography
#' * `geot` = Geography Type
#' * `rls` = Release
#' * `seas` = Seasonal Adjustment
#' * `src` = Source
#'
#' @param search_text A string containing the words to match against.
#'
#' @param order_by A string indicating the attribute to order results by.
#' Consult the API documentation of your endpoint for specific information.
#'
fredr_options <- function(
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
  output_type = NULL,
  tag_names = NULL,
  exclude_tag_names = NULL,
  tag_group_id = NULL,
  search_text = NULL
) {

  # Validation - series

  # Validation - search

  # Validation - dates
  date_lst <- list(observation_start, observation_end, realtime_start, realtime_end, vintage_dates)
  date_nms <- list("observation_start", "observation_end", "realtime_start", "realtime_end", "vintage_dates")
  mapply(validate_is_class, date_lst, date_nms, MoreArgs = list(x_class = "Date"))

  # Date formatting
  observation_start <- format_fred_date(observation_start)
  observation_end   <- format_fred_date(observation_end)
  realtime_start    <- format_fred_date(realtime_start)
  realtime_end      <- format_fred_date(realtime_end)
  vintage_dates     <- format_fred_date(vintage_dates)

  # Return list for use in API call
  list(
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
    output_type = output_type,
    tag_names = tag_names,
    exclude_tag_names = exclude_tag_names,
    tag_group_id = tag_group_id,
    search_text = search_text
  )

}

# Option helpers

format_fred_date <- function(x) {
  if(is.null(x)) {
    return(x)
  }

  format(x, "%Y-%m-%d")
}

