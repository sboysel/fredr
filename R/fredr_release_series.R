#' Get the series on a release of economic data
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
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `1000`, the maximum.
#'
#' @param offset An integer used in conjunction with `limit` for long series.
#' This mimics the idea of _pagination_ to retrieve large amounts of data over
#' multiple calls. Defaults to `0`.
#'
#' @param order_by A string indicating an attribute by which the results are
#' ordered by. Possible values include:
#'
#' * `"series_id"` (default)
#' * `"title"`
#' * `"units"`
#' * `"frequency"`
#' * `"seasonal_adjustment"`
#' * `"realtime_start"`
#' * `"realtime_end"`
#' * `"last_updated"`
#' * `"observation_start"`
#' * `"observation_end"`
#' * `"popularity"`
#' * `"group_popularity"`
#'
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"` (default), and `"desc"`.
#'
#' @param filter_variable A string indicating which attribute to indicate the
#' attribute that results are filtered by.  Possible values include: `"frequency"`,
#' `"units"`, `"seasonal_adjustment"`.  No filtering by default.
#'
#' @param filter_value A string giving the value of the `filter_variable`
#' attribute to filter results by.  `filter_variable` must be set.  No filtering
#' by default.
#'
#' @param tag_names A string indicating which series tags to match.  Multiple
#' tags can be delimited by a semicolon in a single string (e.g. `"usa;gnp"``).
#'
#' @param exclude_tag_names A string indicating which series tags should _not_
#' be matched.  Multiple tags can be delimited by a semicolon in a single string
#' (e.g. `"usa;gnp"``).
#'
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/release/series](https://research.stlouisfed.org/docs/api/fred/release_series.html)
#'
#' @seealso [fredr_releases()], [fredr_releases_dates()], [fredr_release()],
#' [fredr_release_dates()], [fredr_release_sources()], [fredr_release_tags()],
#' [fredr_release_related_tags()], [fredr_release_tables()]
#'
#' @examples
#' if (fredr_has_key()) {
#' fredr_release_series(release_id = 20L)
#'
#' fredr_release_series(release_id = 20L, order_by = "popularity")
#'
#' # Extract the "catalog" of series from a release on a certain date
#' fredr_release_series(
#'    release_id = 20L,
#'    realtime_end = as.Date("2018-07-13"),
#'    order_by = "popularity"
#' )
#' }
#' @export
fredr_release_series <- function(release_id = NULL,
                                 filter_variable = NULL,
                                 filter_value = NULL,
                                 tag_names = NULL,
                                 exclude_tag_names = NULL,
                                 limit = NULL,
                                 offset = NULL,
                                 order_by = NULL,
                                 sort_order = NULL,
                                 realtime_start = NULL,
                                 realtime_end = NULL) {

  validate_release_id(release_id)

  user_args <- capture_args(
    release_id,
    limit,
    offset,
    order_by,
    sort_order,
    filter_variable,
    filter_value,
    tag_names,
    exclude_tag_names,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "release/series"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
