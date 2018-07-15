#' Get a release of economic data
#'
#' @param release_id An integer ID of the release. _Required parameter._
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
#' [fred/release](https://research.stlouisfed.org/docs/api/fred/release.html)
#'
#' @seealso [fredr_releases()], [fredr_releases_dates()], [fredr_release_dates()],
#' [fredr_release_series()], [fredr_release_sources()], [fredr_release_tags()],
#' [fredr_release_related_tags()], [fredr_release_tables()]
#'
#' @examples
#' \dontrun{
#' fredr_release(release_id = 20)
#' }
#' @export
fredr_release <- function(release_id = NULL,
                          realtime_start = NULL,
                          realtime_end = NULL) {

  validate_release_id(release_id)

  user_args <- capture_args(
    release_id,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "release"
  )

  do.call(fredr, c(fredr_args, user_args))

}
