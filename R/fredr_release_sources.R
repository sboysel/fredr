#' Get the sources for a release of economic data
#'
#' @param release_id An integer ID of the release.
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
#' [fred/release/sources](https://fred.stlouisfed.org/docs/api/fred/release_sources.html)
#'
#' @seealso [fredr_releases()], [fredr_releases_dates()], [fredr_release()],
#' [fredr_release_dates()], [fredr_release_series()], [fredr_release_tags()],
#' [fredr_release_related_tags()], [fredr_release_tables()]
#'
#' @examples
#' if (fredr_has_key()) {
#' # Where does the data for ID 10 come from?
#' fredr_release_sources(release_id = 10L)
#' }
#' @export
fredr_release_sources <- function(release_id,
                                  ...,
                                  realtime_start = NULL,
                                  realtime_end = NULL) {
  check_dots_empty(...)
  check_not_null(release_id, "release_id")

  user_args <- capture_args(
    release_id = release_id,
    realtime_start = realtime_start,
    realtime_end = realtime_end
  )

  fredr_args <- list(
    endpoint = "release/sources"
  )

  do.call(fredr_request, c(fredr_args, user_args))
}
