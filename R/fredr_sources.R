#' Get _all_ sources of economic data
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
#' @param offset An integer used in conjunction with limit for long series.
#' This mimics the idea of _pagination_ to retrieve large amounts of data over
#' multiple calls. Defaults to `0`.
#'
#' @param order_by A string indicating which attribute should be used to order
#' the results.  Possible values: `"source_id"` (default), `"name"`,
#' `"realtime_start"`, `"realtime_end"`.
#'
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"` (default), and `"desc"`.
#'
#' @param ... These dots only exist for future extensions and should be empty.
#'
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/sources](https://research.stlouisfed.org/docs/api/fred/sources.html)
#'
#' @seealso [fredr_source()], [fredr_source_releases()]
#'
#' @examples
#' if (fredr_has_key()) {
#' fredr_sources(limit = 20L)
#' }
#' @export
fredr_sources <- function(...,
                          limit = NULL,
                          offset = NULL,
                          order_by = NULL,
                          sort_order = NULL,
                          realtime_start = NULL,
                          realtime_end = NULL) {
  check_dots_empty(...)

  user_args <- capture_args(
    limit = limit,
    offset = offset,
    order_by = order_by,
    sort_order = sort_order,
    realtime_start = realtime_start,
    realtime_end = realtime_end
  )

  fredr_args <- list(
    endpoint = "sources"
  )

  do.call(fredr_request, c(fredr_args, user_args))
}
