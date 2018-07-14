#' Find FRED series matching tag names
#'
#' Get the series matching the `tag_names` parameter. Exclude tags in the
#' `exclude_tag_names` parameter.
#'
#' @inheritParams fredr_related_tags
#'
#' @param tag_names A semicolon delimited string of tag names to
#' find series using. _Required parameter._
#'
#' @return A data frame containing tags related to `tag_names` and their
#' descriptions.
#'
#' @section API Documentation:
#'
#' [fred/tags/series](https://research.stlouisfed.org/docs/api/fred/tags_series.html)
#'
#' @seealso [fredr_docs()], [fredr_series_search_tags()], [fredr_series_search_related_tags()],
#' [fredr_related_tags()], [fredr_tags()]
#'
#' @export
#'
#' @examples
#'
#' \dontrun{
#'
#' fredr_tags_series(tag_names = "gdp")
#'
#' fredr_tags_series(
#'    tag_names = "gdp",
#'    exclude_tag_names = "quarterly"
#'  )
#'
#' fredr_tags_series(
#'    tag_names = "gdp",
#'    exclude_tag_names = "quarterly",
#'    order_by = "popularity"
#' )
#'
#' }
#'
fredr_tags_series <- function(tag_names = NULL,
                              exclude_tag_names = NULL,
                              realtime_start = NULL,
                              realtime_end = NULL,
                              limit = NULL,
                              offset = NULL,
                              order_by = NULL,
                              sort_order = NULL) {

  user_args <- capture_args(
    tag_names,
    exclude_tag_names,
    realtime_start,
    realtime_end,
    limit,
    offset,
    order_by,
    sort_order
  )

  fredr_args <- list(
    endpoint = "tags/series"
  )

  frame <- do.call(fredr, c(fredr_args, user_args))

  frame
}
