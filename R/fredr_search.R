#' Search for a FRED series.
#'
#' @param ... A series of paramters to be used in the query.  Of the form 
#' param_key = 'param_value'.  The parameter \code{search_text} is required for 
#' \code{series/search} and \code{series_search_text} is required for 
#' \code{series/search/tags} or \code{series/search/related_tags}.
#' @param search_field A string indicating to search for a series, series tags, 
#' or related series tags.  Default is "series" to search for a series.  Use
#' "tags" to search tags and "related_tags" to search related tags.
#' @return A \code{ts} object.
#' @examples
#' fredr_search(search_text = "oil", order_by = "popularity")
#' @export
fredr_search <- function(search_field = "series", ...) {
  if (!(search_field %in% c("series", "tags", "related_tags"))) {
    stop("search_type parameter must be one of 'series', 'tags', or \
         'related_tags'")
  }
  params <- list(...)
  if (search_field == "series") {
    if (!("search_text" %in% names(params))) {
      stop("Missing search_text parameter.")
    } else {
      frame <- fredr::fredr(endpoint = "series/search", ...)
    }
  }
  if (search_field %in% c("tags", "related_tags")) {
    if (!("series_search_text" %in% names(params))) {
      stop("Missing 'series_search_text' parameter.")
    } else if (search_field == "tags") {
      frame <- fredr::fredr(endpoint = "series/search/tags", ...)
    } else if (!("tag_names" %in% names(params))) {
      stop("Missing 'tag_names' parameter.")
    } else {
      frame <- fredr::fredr(endpoint = "series/search/related_tags", ...)
    }
  }
  return(frame)
}
