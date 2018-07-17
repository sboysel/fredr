#' Get the FRED tags for a series search.
#'
#' Return the FRED tags by searching for matches in series text.
#'
#' @inheritParams fredr_series_observations
#'
#' @param series_search_text A string containing the series search text.
#' _Required parameter._
#'
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `1000`, the maximum.
#'
#' @param order_by A string indicating the attribute to order results by.
#' Defaults to `"series_count"`. Possible values are:
#'
#' * `"series_count"`
#' * `"popularity"`
#' * `"created"`
#' * `"name"`
#' * `"group_id"`
#'
#' @param tag_names A semicolon delimited string of tag names to return.  Defaults
#' no filtering by tag names.
#'
#' @param tag_group_id A string indicating the tag group id to filter tags by type.
#' Defaults to no filtering by tag group.  Possible values are
#'
#' * `"freq"` = Frequency
#' * `"gen"` = General or Concept
#' * `"geo"` = Geography
#' * `"geot"` = Geography Type
#' * `"rls"` = Release
#' * `"seas"` = Seasonal Adjustment
#' * `"src"` = Source
#'
#' @param tag_search_text A string to match tag names.  Defaults to no filtering
#' by tag name matching.
#'
#' @return A `tibble` object where each row represents a series tag matching the
#' query.  Data include the tag name, group ID, tag creation date, popularity,
#' series count, and additional notes.
#'
#' @references API Documentation:
#'
#' [series/search/tags](https://research.stlouisfed.org/docs/api/fred/series_search_tags.html)
#'
#' @seealso [fredr_series_search_text()], [fredr_series_search_id()], [fredr_series_search_related_tags()], [fredr_tags()]
#'
#' @examples
#' \dontrun{
#' # Search for tags matching the series text "gnp"
#' fredr_series_search_tags("gnp")
#' # Search for tags matching the series text "oil" and the tag text "usa"
#' fredr_series_search_tags(
#'   series_search_text = "oil",
#'   tag_search_text = "usa"
#' )
#' # Search for tags matching the series text "oil" and the tag text "usa".
#' # Return only results in the "geo" (Geography) group
#' fredr_series_search_tags(
#'   series_search_text = "oil",
#'   tag_search_text = "usa",
#'   tag_group_id = "geo"
#' )
#' }
#' @name fredr_series_search_tags
#' @export
fredr_series_search_tags <- function(series_search_text = NULL,
                                     limit = NULL,
                                     offset = NULL,
                                     order_by = NULL,
                                     sort_order = NULL,
                                     tag_names = NULL,
                                     tag_group_id = NULL,
                                     tag_search_text = NULL,
                                     realtime_start = NULL,
                                     realtime_end = NULL) {

  validate_required_string_param(series_search_text)

  args <- capture_args(
    series_search_text,
    limit,
    offset,
    order_by,
    sort_order,
    tag_names,
    tag_group_id,
    tag_search_text,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(endpoint = "series/search/tags")

  do.call(fredr, c(fredr_args, args))
}
