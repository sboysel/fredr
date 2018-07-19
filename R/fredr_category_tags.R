#' Get the FRED tags for a category
#'
#' Get the FRED tags for a category. Optionally, filter results by tag name,
#' tag group, or search. Series are assigned tags and categories. Alternatively,
#' it is possible to get the tags for a category through a call to a function in
#' the `fredr/series` endpoint.  See [fredr_series]. No tags exist for a category
#' that does not have series.
#'
#' @param category_id An integer ID for the category.  Default is `0` for the
#' root category. _Required parameter._
#'
#' @param tag_names A string indicating which series tags to match.  Multiple
#' tags can be delimited by a semicolon in a single string (e.g. `"usa;gnp"``).
#'
#' @param tag_group_id A string representing the tag group id to filter tags by
#' type.  No filtering by default.  Possible values include:
#'
#' * `"freq"` - Frequency
#' * `"gen"` - General or Concept
#' * `"geo"` - Geography
#' * `"geot"` - Geography Type
#' * `"rls"` - Release
#' * `"seas"` - Seasonal Adjustment
#' * `"src"` - Source
#'
#' @param search_text A string to match text of tags.  No matching by default.
#'
#' @param limit An positive integer indicating maximum number of results to return.  Possible
#' values are any integer between `1` and `1000` (default), inclusive.
#'
#' @param offset An non-negative integer used in conjunction with `limit` for
#' long series.  This mimics the idea of _pagination_ to retrieve large amounts
#' of data over multiple calls. Defaults to `0`.
#'
#' @param order_by Order results by values of the specified attribute.
#' Possible values include: `"series_count"` (default), `"popularity"``,
#' `"created"`, `"name"`, `"group_id"`.
#'
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"` (default), and `"desc"`.
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @return A `tibble` object information on tags matching the request and their
#' descriptions.  Data include tag name, group ID, popularity, series count, tag
#' creation date, and additional notes.
#'
#' @section API Documentation:
#'
#' [fred/category/tags](https://research.stlouisfed.org/docs/api/fred/category_tags.html)
#'
#' @seealso [fredr_category()], [fredr_category_children()], [fredr_category_related()],
#' [fredr_category_series()], [fredr_category_related_tags()]
#'
#' @examples
#' \dontrun{
#' # Tags assigned to series in the "Production & Business Activity" category
#' fredr_category_tags(category = 1L)
#' # Select the "nation" and "monthly" tags in the "Production & Business Activity" category
#' fredr_category_tags(category = 3L, tag_names = "nation;monthly", order_by = "popularity")
#' }
#' @export
fredr_category_tags <- function(category_id = 0L,
                                tag_names = NULL,
                                tag_group_id = NULL,
                                search_text = NULL,
                                limit = NULL,
                                offset = NULL,
                                order_by = NULL,
                                sort_order = NULL,
                                realtime_start = NULL,
                                realtime_end = NULL) {

  validate_category_id(category_id)

  user_args <- capture_args(
    category_id,
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
    endpoint = "category/tags"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
