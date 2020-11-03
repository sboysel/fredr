#' Get release dates for a single release of economic data
#'
#' @param release_id An integer ID of the release. _Required parameter._
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#' Defaults to `1776-07-04` (earliest available). For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#' Defaults to `9999-12-31` (latest available). For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `10000`, the maximum.
#'
#' @param offset An integer used in conjunction with `limit` for long series.
#' This mimics the idea of _pagination_ to retrieve large amounts of data over
#' multiple calls. Defaults to `0`.
#'
#' @param sort_order A string representing the order of the resulting release
#' dates. Possible values are: `"asc"` (default), and `"desc"`.
#'
#' @param include_release_dates_with_no_data A boolean value indicating if the
#' results with no data available should be returned as well.
#' Default is `FALSE`.
#'
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/release/dates](https://research.stlouisfed.org/docs/api/fred/release_dates.html)
#'
#' @seealso [fredr_releases()], [fredr_releases_dates()], [fredr_release()],
#' [fredr_release_series()], [fredr_release_sources()], [fredr_release_tags()],
#' [fredr_release_related_tags()], [fredr_release_tables()]
#'
#' @examples
#' if (fredr_has_key()) {
#' fredr_release_dates(release_id = 20L)
#'
#' # Call the function with an "as of" Date of 1997-03-14
#' fredr_release_dates(release_id = 20L, realtime_end = as.Date("1997-03-14"))
#' }
#' @export
fredr_release_dates <- function(release_id = NULL,
                                limit = NULL,
                                offset = NULL,
                                sort_order = NULL,
                                include_release_dates_with_no_data = NULL,
                                realtime_start = NULL,
                                realtime_end = NULL) {

  validate_release_id(release_id)

  user_args <- capture_args(
    release_id,
    limit,
    offset,
    sort_order,
    include_release_dates_with_no_data,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "release/dates"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
