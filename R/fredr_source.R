#' Get a source of economic data
#'
#' @param source_id An integer ID for the data source.
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://fred.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://fred.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param ... These dots only exist for future extensions and should be empty.
#'
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/source](https://fred.stlouisfed.org/docs/api/fred/source.html)
#'
#' @seealso [fredr_sources()], [fredr_source_releases()]
#'
#' @examples
#' if (fredr_has_key()) {
#' fredr_source(source_id = 14L)
#'
#' # Has this source ID ever changed over time?
#' fredr_source(source_id = 14L, realtime_start = as.Date("1990-01-01"))
#' }
#' @export
fredr_source <- function(source_id,
                         ...,
                         realtime_start = NULL,
                         realtime_end = NULL) {
  check_dots_empty(...)
  check_not_null(source_id, "source_id")

  user_args <- capture_args(
    source_id = source_id,
    realtime_start = realtime_start,
    realtime_end = realtime_end
  )

  fredr_args <- list(
    endpoint = "source"
  )

  do.call(fredr_request, c(fredr_args, user_args))
}
