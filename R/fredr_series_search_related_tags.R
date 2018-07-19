#' Get the related FRED tags for one or more FRED tags matching a series search
#'
#' FRED tags are attributes assigned to series.  Return the _related_ FRED tags
#' for a search: tags assigned to series that match _all_ tags in the `tag_names`
#' parameter (required), _no_ tags in the `exclude_tag_names` (optional) and the
#' search words set by the `series_search_text` parameter (optional).
#'
#' @inheritParams fredr_series_observations
#'
#' @param series_search_text A string containing the series search text.
#' _Required parameter._
#'
#' @param tag_names A semicolon delimited string of tag names to return.  Defaults
#' no filtering by tag names.  _Required parameter._
#'
#' @param exclude_tag_names A semicolon delimited string of tag names that
#' series match _none_ of.  Defaults to no tag filtering.
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
#' @return A `tibble` object.
#'
#' @references API Documentation:
#'
#' [series/search/related_tags](https://research.stlouisfed.org/docs/api/fred/series_search_related_tags.html)
#'
#' @seealso [fredr_series_observations()], [fredr_series_search_text()],
#' [fredr_series_search_id()], [fredr_series_search_tags()],
#' [fredr_series()], [fredr_series_categories()],
#' [fredr_series_release()], [fredr_series_tags()], [fredr_series_updates()],
#' [fredr_series_vintagedates()].
#'
#' @examples
#' \dontrun{
#' # Search for all tags matching the series text "oil" and the tag "usa".
#' fredr_series_search_related_tags(
#'   series_search_text = "oil",
#'   tag_names = "usa"
#' )
#' # Search for tags matching the series text "oil", the tag text "usa", and
#' # are related to the tag "usa".  Return only results in the "src" (Source)
#' # group.
#' fredr_series_search_related_tags(
#'   series_search_text = "oil",
#'   tag_names = "usa",
#'   tag_group_id = "src",
#'   tag_search_text = "usa"
#' )
#' }
#' @rdname fredr_series_search_related_tags
#' @export
fredr_series_search_related_tags <- function(series_search_text = NULL,
                                             tag_names = NULL,
                                             exclude_tag_names = NULL,
                                             tag_group_id = NULL,
                                             tag_search_text = NULL,
                                             limit = NULL,
                                             offset = NULL,
                                             order_by = NULL,
                                             sort_order = NULL,
                                             realtime_start = NULL,
                                             realtime_end = NULL) {

  validate_required_string_param(series_search_text)

  validate_required_string_param(tag_names)

  args <- capture_args(
    series_search_text,
    tag_names,
    limit,
    offset,
    order_by,
    sort_order,
    exclude_tag_names,
    tag_group_id,
    tag_search_text,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(endpoint = "series/search/related_tags")

  do.call(fredr_request, c(fredr_args, args))
}
