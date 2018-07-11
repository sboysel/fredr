#' Get FRED series tags
#'
#' Get FRED tags. Optionally, filter results by tag name, tag group, or
#' search text. FRED tags are attributes assigned to series. By default,
#' all tags are returned, unfiltered, up to the `limit`, which is `1000`.
#'
#' @inheritParams fredr_series
#'
#' @return A data frame containing tags and their descriptions.
#'
#' @section Optional Parameters:
#'
#' * `realtime_start`
#' * `realtime_end`
#' * `tag_names`
#' * `tag_group_id`
#' * `search_text`
#' * `limit`
#' * `offset`
#' * `order_by`
#' * `sort_order`
#'
#' @section API Documentation:
#'
#' [fred/tags](https://research.stlouisfed.org/docs/api/fred/tags.html)
#'
#' @seealso [fredr_docs()], [fredr_search()], [fredr_series()]
#'
#' @examples
#' \dontrun{
#' library(tidyverse)
#' fredr_tags()
#' fredr_tags(fredr_options(tag_names = "gdp;oecd"))
#' fredr_tags(fredr_options(tag_group_id = "geo"))
#' fredr_tags(fredr_options(search_text = "unemployment"))
#' }
#' @export
#'
fredr_tags <- function(options = fredr_options()) {

  fredr_args <- list(
    endpoint = "tags"
  )

  frame <- do.call(fredr, c(fredr_args, options))

  frame
}
