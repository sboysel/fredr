#' Get related FRED tags given one or more tags
#'
#' Get related FRED tags. Optionally, filter results by tag group, or
#' search text. Related FRED tags are the tags assigned to series that match
#' all tags in the `tag_names` parameter and no tags in the
#' `exclude_tag_names` parameter.
#'
#' @inheritParams fredr_tags
#'
#' @param tag_names A semicolon delimited string of tag names to be related to.
#' _Required parameter._
#'
#' @param exclude_tag_names A semicolon delimted string of tag names that series
#' match none of. No exclusions are done by default.
#'
#' @return A data frame containing tags related to `tag_names` and their
#' descriptions.
#'
#' @export
#'
#' @examples
#'
#' \dontrun{
#'
#' fredr_related_tags(tag_names = "monetary aggregates;weekly")
#'
#' fredr_related_tags(
#'    tag_names = "monetary aggregates;weekly",
#'    tag_group_id = "gen"
#'  )
#'
#'  }
#'
fredr_related_tags <- function(tag_names = NULL,
                               realtime_start = NULL,
                               realtime_end = NULL,
                               exclude_tag_names = NULL,
                               tag_group_id = NULL,
                               search_text = NULL,
                               limit = NULL,
                               offset = NULL,
                               order_by = NULL,
                               sort_order = NULL) {

  validate_required_string_param(tag_names)

  user_args <- capture_args(
    tag_names,
    realtime_start,
    realtime_end,
    exclude_tag_names,
    tag_group_id,
    search_text,
    limit,
    offset,
    order_by,
    sort_order
  )

  fredr_args <- list(
    endpoint = "related_tags"
  )

  frame <- do.call(fredr, c(fredr_args, user_args))

  frame
}
