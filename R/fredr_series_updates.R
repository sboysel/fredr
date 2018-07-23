#' Get a set of recently updated FRED series
#'
#' Returns information on the recently updated series on the FRED server.
#'
#' @inheritParams fredr_series_observations
#'
#' @param filter_value Filter results by type of geographic region of economic
#' the data series.  Possible values include
#'
#' * `"all"` (default) - no filtering
#' * `"macro"` - filters results macroeconomic regions (e.g. entire countries)
#' * `"regional"` - filters results to series for regions of the United States
#' such as states, counties, and Metropolitan Statistical Areas (MSA).
#'
#' @param start_time A datetime object indicating the start time to filter series
#' updates results.
#'
#' @param end_time A datetime object indicating the start time to filter series
#' updates results.
#'
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `1000`, the maximum.
#'
#' @return A `tibble` object where each row represents a series. Rows are sorted
#' with most recently updated series appearing first.
#'
#' @section API Documentation:
#'
#' [fred/series/updates](https://research.stlouisfed.org/docs/api/fred/series_updates.html)
#'
#' @seealso [fredr_series_observations()], [fredr_series_search_text()],
#' [fredr_series_search_id()], [fredr_series_search_tags()],
#' [fredr_series_search_related_tags()], [fredr_series()],
#' [fredr_series_release()], [fredr_series_tags()], [fredr_series_categories()],
#' [fredr_series_vintagedates()].
#'
#' @examples
#' \donttest{
#' # Get all recently updated "regional" series
#' fredr_series_updates(filter_value = "regional")
#' # Most recently udpated series are returned first
#' updates <- fredr_series_updates(filter_value = "regional")$last_updated
#' is.unsorted(rev(as.POSIXct(updates)))
#' }
#' @export
fredr_series_updates <- function(filter_value = NULL,
                                 start_time = NULL,
                                 end_time = NULL,
                                 limit = NULL,
                                 offset = NULL,
                                 realtime_start = NULL,
                                 realtime_end = NULL) {

  user_args <- capture_args(
    limit,
    offset,
    filter_value,
    start_time,
    end_time,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series/updates"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
