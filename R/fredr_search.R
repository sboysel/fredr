#' Search for a FRED series.
#'
#' @param search_text A character vector of length 1.
#' @param series_search_text A character vector of length 1.
#' @param tag_names A character vector of length 1.  Note that this value must be a valid FRED series tag (e.g. \code{30-year},
#'        \code{usa}, \code{quarterly}, etc.)
#' @param ... A series of additional paramters to be used in the query.  Of the form
#'        param_key = 'param_value'.  See \code{fredr_docs("series/search")},
#'        \code{fredr_docs("series/search"/tags)}, or
#'        \code{fredr_docs("series/search/related_tags")} for further details.
#'
#' @return A \code{data.frame}.
#'
#' @details \itemize{
#'   \item{\code{fredr_search}}{Get economic data series that match search text (by full text of series).}
#'   \item{\code{fredr_search_id}}{Get economic data series that match search text (by series ID).}
#'   \item{\code{fredr_search_tags}}{Get the FRED tags for a series search.}
#'   \item{\code{fredr_search_rel_tags}}{Get the related FRED tags for one or more FRED tags matching a series search.}
#' }
#' From the FRED API documentation on \code{series/search/related_tags}: FRED tags are
#' attributes assigned to series. For this request, related FRED tags are the tags assigned
#' to series that match all tags in the \code{tag_names} parameter, no tags in the \code{exclude_tag_names}
#' parameter, and the search words set by the \code{series_search_text} parameter.
#'
#' @references See \url{https://research.stlouisfed.org/docs/api/fred/series_search_related_tags.html}.
#'
#' @examples
#' \dontrun{
#' fredr_search("oil", order_by = "popularity")
#' fredr_search("UNRATE", order_by = "popularity")
#' fredr_search_tags("gnp")
#' fredr_search_rel_tags("gnp", "usa")
#' }
#' @name fredr_search
#' @export
fredr_search <- function(search_text = NULL, ...) {
  stopifnot(!is.null(search_text))
  fredr::fredr(
    endpoint = "series/search",
    search_text = search_text,
    search_type = "full_text",
    ...
  )
}

#' @rdname fredr_search
fredr_search_id <- function(search_text = NULL, ...) {
  stopifnot(!is.null(search_text))
  fredr::fredr(
    endpoint = "series/search",
    search_text = search_text,
    search_type = "series_id",
    ...
  )
}

#' @rdname fredr_search
fredr_search_tags <- function(series_search_text = NULL, ...) {
  stopifnot(!is.null(series_search_text))
  fredr::fredr(
    endpoint = "series/search/tags",
    series_search_text = series_search_text,
    ...
  )
}

#' @rdname fredr_search
fredr_search_rel_tags <- function(series_search_text = NULL, tag_names = NULL, ...) {
  stopifnot(!is.null(series_search_text), !is.null(tag_names))
  fredr::fredr(
    endpoint = "series/search/related_tags",
    series_search_text = series_search_text,
    tag_names = tag_names,
    ...
  )
}
