#' Get related FRED tags given one or more tags
#'
#' Get related FRED tags. Optionally, filter results by tag group, or
#' search text. Related FRED tags are the tags assigned to series that match
#' _all_ tags in the `tag_names` parameter and _no_ tags in the
#' `exclude_tag_names` parameter.
#'
#' @inheritParams fredr_tags
#'
#' @param tag_names A semicolon delimited string of tag names to be related to.
#'
#' @param exclude_tag_names A semicolon delimited string of tag names that series
#' match _none_ of. No exclusions are done by default.
#'
#' @return A `tibble` containing tags related to `tag_names` and their
#' descriptions.  Data include tag name, group ID, popularity, series count, tag
#' creation date, and additional notes.
#'
#' @section API Documentation:
#'
#' [fred/related_tags](https://fred.stlouisfed.org/docs/api/fred/related_tags.html)
#'
#' @seealso [fredr_category_tags()], [fredr_category_related_tags()], [fredr_docs()],
#' [fredr_release_tags()], [fredr_release_related_tags()],
#' [fredr_series_search_tags()], [fredr_series_search_related_tags()],
#' [fredr_tags_series()], [fredr_tags()]
#'
#' @examples
#'
#' if (fredr_has_key()) {
#'
#' fredr_related_tags(tag_names = "monetary aggregates;weekly")
#'
#' fredr_related_tags(
#'    tag_names = "monetary aggregates;weekly",
#'    tag_group_id = "gen"
#'  )
#'
#'  }
#' @export
fredr_related_tags <- function(tag_names,
                               ...,
                               exclude_tag_names = NULL,
                               tag_group_id = NULL,
                               search_text = NULL,
                               limit = NULL,
                               offset = NULL,
                               order_by = NULL,
                               sort_order = NULL,
                               realtime_start = NULL,
                               realtime_end = NULL) {
  check_dots_empty(...)
  check_not_null(tag_names, "tag_names")

  user_args <- capture_args(
    tag_names = tag_names,
    realtime_start = realtime_start,
    realtime_end = realtime_end,
    exclude_tag_names = exclude_tag_names,
    tag_group_id = tag_group_id,
    search_text = search_text,
    limit = limit,
    offset = offset,
    order_by = order_by,
    sort_order = sort_order
  )

  fredr_args <- list(
    endpoint = "related_tags"
  )

  do.call(fredr_request, c(fredr_args, user_args))
}
