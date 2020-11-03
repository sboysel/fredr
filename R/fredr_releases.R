#' Get all releases of economic data
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
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/releases](https://research.stlouisfed.org/docs/api/fred/releases.html)
#'
#' @seealso [fredr_releases_dates()], [fredr_release()], [fredr_release_dates()],
#' [fredr_release_series()], [fredr_release_sources()], [fredr_release_tags()],
#' [fredr_release_related_tags()], [fredr_release_tables()],
#'
#' @examples
#' if (fredr_has_key()) {
#' fredr_releases(limit = 20L)
#' }
#' @export
fredr_releases <- function(limit = NULL,
                           offset = NULL,
                           order_by = NULL,
                           sort_order = NULL,
                           realtime_start = NULL,
                           realtime_end = NULL) {

  user_args <- capture_args(
    limit = limit,
    offset = offset,
    order_by = order_by,
    sort_order = sort_order,
    realtime_start = realtime_start,
    realtime_end = realtime_end
  )

  fredr_args <- list(
    endpoint = "releases"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
