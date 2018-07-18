#' Get a source of economic data
#'
#' @param source_id An integer ID for the data source.  _Required parameter_.
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
#' [fred/source](https://research.stlouisfed.org/docs/api/fred/source.html)
#'
#' @seealso [fredr_sources()], [fredr_source_releases()]
#'
#' @examples
#' \dontrun{
#' fredr_source(source_id = 14L)
#'
#' # Has this source ID ever changed over time?
#' fredr_source(source_id = 14L, realtime_start = as.Date("1990-01-01"))
#' }
#' @export
fredr_source <- function(source_id = NULL,
                         realtime_start = NULL,
                         realtime_end = NULL) {

  validate_source_id(source_id)

  user_args <- capture_args(
    source_id,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "source"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
