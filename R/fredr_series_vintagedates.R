#' Get the data vintage dates for a FRED series
#'
#' Given a series ID, return a sequence of dates in history when a series'
#' data values were revised or new data values were released as a `tibble` object.
#'
#' @inheritParams fredr_series_observations
#'
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `1000`, the maximum.
#'
#' @return A `tibble` object where each row is a distinct vintage date.
#'
#' @section API Documentation:
#'
#' [fred/series/vintagedates](https://research.stlouisfed.org/docs/api/fred/series_vintagedates.html)
#'
#' @seealso [fredr_series_observations()], [fredr_series_search_text()],
#' [fredr_series_search_id()], [fredr_series_search_tags()],
#' [fredr_series_search_related_tags()], [fredr_series()],
#' [fredr_series_release()], [fredr_series_tags()], [fredr_series_categories()],
#' [fredr_series_updates()].
#'
#' @examples
#' \donttest{
#' # All data vintages for the "UNRATE" series
#' fredr_series_vintagedates(series_id = "UNRATE")
#' # 10 most recent data vintages for the "UNRATE" series
#' fredr_series_vintagedates(series_id = "UNRATE", limit = 10L, sort_order = "desc")
#' }
#' @export
fredr_series_vintagedates <- function(series_id = NULL,
                                      limit = NULL,
                                      offset = NULL,
                                      sort_order = NULL,
                                      realtime_start = NULL,
                                      realtime_end = NULL) {

  validate_series_id(series_id)

  user_args <- capture_args(
    series_id,
    limit,
    offset,
    sort_order,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series/vintagedates"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}

