#' Get all sources of economic data
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param limit An positive integer indicating maximum number of results to return.  Possible
#' values are any integer between `1` and `1000` (default), inclusive.
#'
#' @param offset An non-negative integer indicating how many records to offset
#' the returned results.  Default is `0`.
#'
#' @param order_by A string indicating which attribute should be used to order
#' the results.  Possible values: `"source_id"` (default), `"name"`,
#' `"realtime_start"`, `"realtime_end"`.
#'
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"` (default), and `"desc"`.
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
#' \dontrun{
#' fredr_sources(limit = 20L)
#' }
#' @export
fredr_sources <- function(limit = NULL,
                          offset = NULL,
                          order_by = NULL,
                          sort_order = NULL,
                          realtime_start = NULL,
                          realtime_end = NULL) {

  user_args <- capture_args(
    realtime_start,
    realtime_end,
    limit,
    offset,
    order_by,
    sort_order
  )

  fredr_args <- list(
    endpoint = "sources"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
