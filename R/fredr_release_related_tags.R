#' Get the related FRED tags for one or more FRED tags within a release
#'
#' FRED tags are attributes assigned to series. For this request, related FRED
#' tags are the tags assigned to series that match all tags in the `tag_names`
#' parameter, no tags in the `exclude_tag_names` parameter, and the
#' release set by the `release_id` parameter.
#'
#' @param release_id An integer ID of the release. _Required parameter._
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
#' \donttest{
#' fredr_release_related_tags(10, tag_names = "cpi")
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

  do.call(fredr_request, c(fredr_args, user_args))

}
