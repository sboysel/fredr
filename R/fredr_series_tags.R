#' Get the tags for a FRED series
#'
#' Given a series ID, return associated tags for the series as a `tibble` object.
#'
#' @inheritParams fredr_series_observations
#'
#' @param order_by A string indicating the attribute by which to order the
#' Possible values include `"series_count"` (default), `"popularity"`,
#' `"created"`, `"name"`, and `"group_id"`.
#'
#' @return A `tibble`` object where each row is represents a tag associated with
#' the series specified by `series_id`.  Data include tag name, group ID,
#' popularity, series count, tag creation date, and additional notes.
#'
#' @section API Documentation:
#'
#' [fred/series/tags](https://research.stlouisfed.org/docs/api/fred/series_tags.html)
#'
#' @seealso [fredr_series_observations()], [fredr_series_search_text()],
#' [fredr_series_search_id()], [fredr_series_search_tags()],
#' [fredr_series_search_related_tags()], [fredr_series()],
#' [fredr_series_categories()], [fredr_series_release()], [fredr_series_updates()],
#' [fredr_series_vintagedates()].
#'
#' @examples
#' \dontrun{
#' # Return all tags assigned to the "UNRATE" series and order the results by
#' # group ID.
#' fredr_series_tags(series_id = "UNRATE", order_by = "group_id")
#' }
#' @export
fredr_series_tags <- function(series_id = NULL,
                              order_by = NULL,
                              sort_order = NULL,
                              realtime_start = NULL,
                              realtime_end = NULL) {

  validate_series_id(series_id)

  user_args <- capture_args(
    series_id,
    order_by,
    sort_order,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series/tags"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
