#' Get the release for a FRED series
#'
#' Given a series ID, return information on a series as a `tibble` object.
#'
#' @inheritParams fredr_series_observations
#'
#' @return A `tibble` object with information on the release for the series specified
#' by the `series_id` parameter.  Data include release ID, real-time periods, release name,
#' and links to press releases, if available.
#'
#' @section API Documentation:
#'
#' [fred/series/release](https://research.stlouisfed.org/docs/api/fred/series_release.html)
#'
#' @seealso [fredr_series_observations()], [fredr_series_search_text()],
#' [fredr_series_search_id()], [fredr_series_search_tags()],
#' [fredr_series_search_related_tags()], [fredr_series()],
#' [fredr_series_categories()], [fredr_series_tags()], [fredr_series_updates()],
#' [fredr_series_vintagedates()].
#'
#' @examples
#' if (fredr_has_key()) {
#' # Get release information for the "UNRATE" series
#' fredr_series_release(series_id = "UNRATE")
#' }
#' @export
fredr_series_release <- function(series_id,
                                 ...,
                                 realtime_start = NULL,
                                 realtime_end = NULL) {
  check_dots_empty(...)
  check_not_null(series_id, "series_id")

  user_args <- capture_args(
    series_id = series_id,
    realtime_start = realtime_start,
    realtime_end = realtime_end
  )

  fredr_args <- list(
    endpoint = "series/release"
  )

  do.call(fredr_request, c(fredr_args, user_args))
}
