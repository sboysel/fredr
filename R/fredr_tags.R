#' Get FRED series tags
#'
#' List or search (by series text, tag names, or by tag group id) FRED series tags.
#'
#' @param ... A series of named parameters to be used in the query.  Must be of the form
#'        \code{param_key = "param_value"}.  See the \href{https://research.stlouisfed.org/docs/api/fred/tags.html}{Tags}
#'         documentation for a list of accepted parameters.
#'
#' @return a data frame.
#'
#' @references \url{https://research.stlouisfed.org/docs/api/fred/tags.html}.
#' @seealso \code{\link[fredr]{fredr_docs}}, \code{\link[fredr]{fredr_search}}, \code{\link[fredr]{fredr_series}}
#'
#' @examples
#' \dontrun{
#' library(tidyverse)
#' fredr_tags()
#' fredr_tags(tag_names = "gdp;oecd")
#' fredr_tags(tag_group_id = "geo")
#' fredr_tags(search_text = "unemployment")
#' }
#' @export
fredr_tags <- function(...) {
  fredr::fredr(
    endpoint = "tags",
    ...,
    to_frame = TRUE,
    print_req = FALSE
  )
}
