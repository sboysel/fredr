#' Get the related FRED tags for one or more FRED tags within a release
#'
#' @param release_id An integer ID of the release. _Required parameter._
#'
#' @param tag_names A string of tags to include in the response.  Multiple tags
#' can be delimited by a semicolon in a single string. _Required parameter._
#'
#' @param exclude_tag_names A string of tags to _not_ include in the response.
#' Multiple tags can be delimited by a semicolon in a single string.
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
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"` (default), and `"desc"`.
#'
#' @param order_by Order results by values of the specified attribute.
#' Possible values include: `"series_count"` (default), `"popularity"``,
#' `"created"`, `"name"`, `"group_id"`.
#'
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/release/related_tags](https://research.stlouisfed.org/docs/api/fred/release_related_tags.html)
#'
#' @seealso [fredr_releases()],  [fredr_releases_dates()], [fredr_release()],
#' [fredr_release_dates()], [fredr_release_series()], [fredr_release_sources()],
#' [fredr_release_tags()], [fredr_release_tables()]
#'
#' @examples
#' \dontrun{
#' fredr_release_related_tags(release_id = 10L, tag_names = "gnp")
#' }
#' @export
fredr_release_related_tags <- function(release_id = NULL,
                                       tag_names = NULL,
                                       exclude_tag_names = NULL,
                                       tag_group_id = NULL,
                                       search_text = NULL,
                                       limit = NULL,
                                       offset = NULL,
                                       order_by = NULL,
                                       sort_order = NULL,
                                       realtime_start = NULL,
                                       realtime_end = NULL) {

  validate_release_id(release_id)

  validate_required_string_param(tag_names)

  user_args <- capture_args(
    release_id,
    tag_names,
    exclude_tag_names,
    tag_group_id,
    search_text,
    limit,
    offset,
    order_by,
    sort_order,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "release/related_tags"
  )

  do.call(fredr, c(fredr_args, user_args))

}
