#' Return basic information for a FRED series.
#'
#' Given a series ID, return basic information for a FRED series.  Note that
#' this function will _not_ return the actual series data.  For this functionality,
#' see [fredr_series_observations()].
#'
#' @inheritParams fredr_series_observations
#'
#' @return A `tibble` object (1 row) with information for the series specified by
#' `series_id`.
#'
#' @section API Documentation:
#'
#' [fred/series](https://research.stlouisfed.org/docs/api/fred/series.html)
#'
#' @seealso [fredr_series_observations()], [fredr_series_search_text()],
#' [fredr_series_search_id()], [fredr_series_search_tags()],
#' [fredr_series_search_related_tags()], [fredr_series_categories()],
#' [fredr_series_release()], [fredr_series_tags()], [fredr_series_updates()],
#' [fredr_series_vintagedates()].
#'
#' @examples
#' \donttest{
#' # Return information for the "UNRATE" series
#' fredr_series(series_id = "UNRATE")
#' }
#' @export
fredr_series <- function(series_id = NULL,
                         realtime_start = NULL,
                         realtime_end = NULL) {

  validate_series_id(series_id)

  user_args <- capture_args(
    series_id,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
