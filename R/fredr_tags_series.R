#' Find FRED series matching tag names
#'
#' Get the series matching tags in the `tag_names` parameter. Exclude tags in the
#' `exclude_tag_names` parameter.
#'
#' @inheritParams fredr_related_tags
#'
#' @param tag_names A semicolon delimited string of tag names to
#' find series using. _Required parameter._
#'
#' @param order_by A string indicating which attribute by which to order the
#' results of the query.  Possible values include:
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
#' @return A `tibble` object containing FRED series with tags matching `tag_names`
#' and their descriptions.
#'
#' @section API Documentation:
#'
#' [fred/tags/series](https://research.stlouisfed.org/docs/api/fred/tags_series.html)
#'
#' @seealso [fredr_category_tags()], [fredr_category_related_tags()], [fredr_docs()],
#' [fredr_release_tags()], [fredr_release_related_tags()],
#' [fredr_series_search_tags()], [fredr_series_search_related_tags()],
#' [fredr_tags()], [fredr_related_tags()]
#'
#' @examples
#'
#' \dontrun{
#' # All series tagged with "gdp"
#' fredr_tags_series(tag_names = "gdp")
#' # All series tagged with "gdp" and not tagged with "quarterly"
#' fredr_tags_series(
#'    tag_names = "gdp",
#'    exclude_tag_names = "quarterly"
#'  )
#' # Top 100 most popular non-quarterly series matching GDP
#' fredr_tags_series(
#'    tag_names = "gdp",
#'    exclude_tag_names = "quarterly",
#'    order_by = "popularity",
#'    limit = 100L
#' )
#' }
#' @export
fredr_tags_series <- function(tag_names = NULL,
                              exclude_tag_names = NULL,
                              limit = NULL,
                              offset = NULL,
                              order_by = NULL,
                              sort_order = NULL,
                              realtime_start = NULL,
                              realtime_end = NULL) {

  user_args <- capture_args(
    tag_names,
    exclude_tag_names,
    realtime_start,
    realtime_end,
    limit,
    offset,
    order_by,
    sort_order
  )

  fredr_args <- list(
    endpoint = "tags/series"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
