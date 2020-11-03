#' Get the related FRED tags for one or more FRED tags within a release
#'
#' FRED tags are attributes assigned to series. For this request, related FRED
#' tags are the tags assigned to series that match all tags in the `tag_names`
#' parameter, no tags in the `exclude_tag_names` parameter, and the
#' release set by the `release_id` parameter.
#'
#' @param release_id An integer ID of the release.
#'
#' @inheritParams fredr_related_tags
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
#' if (fredr_has_key()) {
#' fredr_release_related_tags(10, tag_names = "cpi")
#' }
#' @export
fredr_release_related_tags <- function(release_id,
                                       tag_names,
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
  check_not_null(release_id, "release_id")
  check_not_null(tag_names, "tag_names")

  user_args <- capture_args(
    release_id = release_id,
    tag_names = tag_names,
    exclude_tag_names = exclude_tag_names,
    tag_group_id = tag_group_id,
    search_text = search_text,
    limit = limit,
    offset = offset,
    order_by = order_by,
    sort_order = sort_order,
    realtime_start = realtime_start,
    realtime_end = realtime_end
  )

  fredr_args <- list(
    endpoint = "release/related_tags"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
