#' Get release dates for _all_ releases of economic data.
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `1000`, the maximum.
#'
#' @param offset An integer used in conjunction with `limit` for long series.
#' This mimics the idea of _pagination_ to retrieve large amounts of data over
#' multiple calls. Defaults to `0`.
#'
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"` (default), and `"desc"`.
#'
#' @param order_by Order results by values of the specified attribute.
#' Possible values include: `'release_id'` (default), `'name'`, `'press_release'`,
#' `'realtime_start'`, `'realtime_end'`.
#'
#' @param include_release_dates_with_no_data A boolean value indicating if the
#' results with no data available should be returned as well.  Default is `FALSE`.
#'
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/releases/dates](https://research.stlouisfed.org/docs/api/fred/releases_dates.html)
#'
#' @seealso [fredr_releases()], [fredr_release_dates()], [fredr_release()],
#' [fredr_release_series()], [fredr_release_sources()], [fredr_release_tags()],
#' [fredr_release_related_tags()], [fredr_release_tables()]
#'
#' @examples
#' \dontrun{
#' fredr_release_dates(limit = 20L)
#' }
#' @export
fredr_releases_dates <- function(limit = NULL,
                                 offset = NULL,
                                 sort_order = NULL,
                                 order_by = NULL,
                                 include_release_dates_with_no_data = NULL,
                                 realtime_start = NULL,
                                 realtime_end = NULL) {

  user_args <- capture_args(
    limit,
    offset,
    sort_order,
    order_by,
    include_release_dates_with_no_data,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "releases/dates"
  )

  do.call(fredr, c(fredr_args, user_args))

}
