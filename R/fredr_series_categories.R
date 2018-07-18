#' Return the categories for a FRED series
#'
#' Given a series ID, return information on the categories to which a series belongs
#' as a `tibble` object.
#'
#' @inheritParams fredr_series_observations
#'
#' @return A `tibble` object with information on the categories to
#' which the series specified by `series_id` belongs.  Data include category ID,
#' name, parent category ID, and notes.
#'
#' @section API Documentation:
#'
#' [fred/series/categories](https://research.stlouisfed.org/docs/api/fred/series_categories.html)
#'
#' @seealso [fredr_series_observations()], [fredr_series_search_text()],
#' [fredr_series_search_id()], [fredr_series_search_tags()],
#' [fredr_series_search_related_tags()], [fredr_series()],
#' [fredr_series_release()], [fredr_series_tags()], [fredr_series_updates()],
#' [fredr_series_vintagedates()].
#'
#' @examples
#' \dontrun{
#' # Return the categories to which the "UNRATE" series belongs
#' fredr_series_categories(series_id = "UNRATE")
#' }
#' @export
fredr_series_categories <- function(series_id = NULL,
                                    realtime_start = NULL,
                                    realtime_end = NULL) {

  validate_series_id(series_id)

  user_args <- capture_args(
    series_id,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series/categories"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
