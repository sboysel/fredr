#' Get the releases for a source
#'
#' @param source_id An integer ID for the data source.  _Required parameter_.
#'
#' @param limit An positive integer indicating maximum number of results to return.  Possible
#' values are any integer between `1` and `1000` (default), inclusive.
#'
#' @param offset An non-negative integer indicating how many records to offset
#' the returned results.  Default is `0`.
#'
#' @param order_by A string indicating which attribute should be used to order
#' the results.  Possible values: `"release_id"` (default), `"name"`,
#' `"press_release"`, `"realtime_start"`, `"realtime_end"`.
#'
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"` (default), and `"desc"`.
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/source/releases](https://research.stlouisfed.org/docs/api/fred/source_releases.html)
#'
#' @seealso [fredr_sources()], [fredr_source()]
#'
#' @examples
#' \dontrun{
#' fredr_source_releases(source_id = 1L)
#' }
#' @export
fredr_source_releases <- function(source_id = NULL,
                                  limit = NULL,
                                  offset = NULL,
                                  order_by = NULL,
                                  sort_order = NULL,
                                  realtime_start = NULL,
                                  realtime_end = NULL) {

  validate_source_id(source_id)

  user_args <- capture_args(
    realtime_start,
    realtime_end,
    source_id,
    limit,
    offset,
    order_by,
    sort_order
  )

  fredr_args <- list(
    endpoint = "source/releases"
  )

  do.call(fredr, c(fredr_args, user_args))

}
