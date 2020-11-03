#' Get the FRED tags for a release
#'
#' Get the FRED tags for a release. Optionally, filter results by tag name,
#' tag group, or search text.
#'
#' @param release_id An integer ID of the release. _Required parameter._
#'
#' @inheritParams fredr_tags
#'
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/release/tags](https://research.stlouisfed.org/docs/api/fred/release_tags.html)
#'
#' @seealso [fredr_releases()], [fredr_releases_dates()], [fredr_release()],
#' [fredr_release_dates()], [fredr_release_series()], [fredr_release_sources()],
#' [fredr_release_related_tags()], [fredr_release_tables()]
#'
#' @examples
#' if (fredr_has_key()) {
#' fredr_release_tags(release_id = 10L)
#' }
#' @export
fredr_release_tags <- function(release_id = NULL,
                               tag_names = NULL,
                               tag_group_id = NULL,
                               search_text = NULL,
                               limit = NULL,
                               offset = NULL,
                               order_by = NULL,
                               sort_order = NULL,
                               realtime_start = NULL,
                               realtime_end = NULL) {

  validate_release_id(release_id)

  user_args <- capture_args(
    release_id = release_id,
    tag_names = tag_names,
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
    endpoint = "release/tags"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
