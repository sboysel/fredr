#' Get FRED series tags
#'
#' Get FRED tags. Optionally, filter results by tag name, tag group, or
#' search text. FRED tags are attributes assigned to a series. By default,
#' all tags are returned, unfiltered, up to the `limit`.
#'
#' @inheritParams fredr_series_observations
#'
#' @param tag_names A semicolon delimited string of tag names to only
#' include in the response. No filtering by tag names by default (i.e. _all_
#' FRED tags returned).
#'
#' @param tag_group_id A string tag group id to filter tags by type. No filtering
#' by tag group by default. Possible values are:
#'
#' * `"freq"` = Frequency
#' * `"gen"` = General or Concept
#' * `"geo"` = Geography
#' * `"geot"` = Geography Type
#' * `"rls"` = Release
#' * `"seas"` = Seasonal Adjustment
#' * `"src"` = Source
#'
#' @param search_text A string indicating the words to find matching tags with.
#' No filtering by search words by default.
#'
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `1000`, the maximum.
#'
#' @param order_by Order results by values of the specified attribute. Possible
#' values are:
#'
#' * `"series_count"` (default)
#' * `"popularity"`
#' * `"created"`
#' * `"name"`
#' * `"group_id"`
#'
#' @param sort_order A string representing the order of the resulting series,
#' sorted by the attribute values specified by `order_by`. Possible values
#' are: `"asc"` (default), and `"desc"`.
#'
#' @return A `tibble` containing tags and their descriptions.  Data include tag
#' name, group ID, popularity, series count, tag creation date, and additional
#' notes.
#'
#' @section API Documentation:
#'
#' [fred/tags](https://research.stlouisfed.org/docs/api/fred/tags.html)
#'
#' @seealso [fredr_category_tags()], [fredr_category_related_tags()], [fredr_docs()],
#' [fredr_release_tags()], [fredr_release_related_tags()],
#' [fredr_series_search_tags()], [fredr_series_search_related_tags()],
#' [fredr_tags_series()], [fredr_related_tags()]
#'
#' @examples
#' \donttest{
#' # Information for all tags
#' fredr_tags()
#' # Information for just the "gdp" and "oecd" tags
#' fredr_tags(tag_names = "gdp;oecd")
#' # Information for all tags in the "geo" group
#' fredr_tags(tag_group_id = "geo")
#' # Information for tags matching the text "unemployment"
#' fredr_tags(search_text = "unemployment")
#' }
#' @export
fredr_tags <- function(tag_names = NULL,
                       tag_group_id = NULL,
                       search_text = NULL,
                       limit = NULL,
                       offset = NULL,
                       order_by = NULL,
                       sort_order = NULL,
                       realtime_start = NULL,
                       realtime_end = NULL) {

  user_args <- capture_args(
    realtime_start,
    realtime_end,
    tag_names,
    tag_group_id,
    search_text,
    limit,
    offset,
    order_by,
    sort_order
  )

  fredr_args <- list(
    endpoint = "tags"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
