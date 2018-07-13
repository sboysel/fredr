#' Search for a FRED series.
#'
#' Search FRED for a series.  Searches can be performed by the text of the series
#' (\code{fredr_search}), by series ID (\code{fredr_search_id}), by series tags
#' (\code{fredr_search_tags}), or related tags (\code{fredr_search_rel_tags}).
#'
#' @inheritParams fredr_series_observations
#'
#' @param search_text A string containing the words to match against economic
#' data series. For use with \code{\link{fredr_search}} and
#' \code{\link{fredr_search_id}}. See Details for more information.
#'
#' @param series_search_text A string containing the search text.  For use with \code{\link{fredr_search_tags}}
#' and \code{\link{fredr_search_rel_tags}}.  See Details for more information.
#'
#' @param order_by A string indicating the attribute to order results by.
#' Defaults to `"search_rank"` if `search_type = "full_text"` and `"series_id"`
#' if `search_type = "series_id"`. Possible values are:
#'
#' * `"search_rank"`
#' * `"series_id"`
#' * `"title"`
#' * `"units"`
#' * `"frequency"`
#' * `"seasonal_adjustment"`
#' * `"realtime_start"`
#' * `"realtime_end"`
#' * `"last_updated"`
#' * `"observation_start"`
#' * `"observation_end"`
#' * `"popularity"`
#' * `"group_popularity"`
#'
#' @param filter_variable A string indicating the attribute to filter results
#' by. Possible values are: `"frequency"`, `"units"`, `"seasonal_adjustment"`.
#' Defaults to no filter.
#'
#' @param filter_value The value of the `filter_variable` attribute to filter
#' by. Possible values depend on the value of `filter_variable`. Defaults to
#' no filter.
#'
#' @param exclude_tag_names A semicolon delimited string of tag names that
#' series match _none_ of.
#'
#' @return A data frame.
#'
#' @details Search by various series characteristics:
#'
#' \itemize{
#'   \item{\code{\link{fredr_search}}}{Get economic data series that match search text (by full text of series).}
#'   \item{\code{\link{fredr_search_id}}}{Get economic data series that match search text (by series ID).}
#'   \item{\code{\link{fredr_search_tags}}}{Get the FRED tags for a series search.}
#'   \item{\code{\link{fredr_search_rel_tags}}}{Get the related FRED tags for one or more FRED tags matching a series search.
#'   See below for more information about searching for related tags.}
#' }
#' From the FRED API documentation on \code{series/search/related_tags}: FRED tags are
#' attributes assigned to series. For this request, related FRED tags are the tags assigned
#' to series that match all tags in the \code{tag_names} parameter, no tags in the \code{exclude_tag_names}
#' parameter, and the search words set by the \code{series_search_text} parameter.
#'
#' @references See FRED API documentation on
#' \href{https://research.stlouisfed.org/docs/api/fred/series_search_related_tags.html}{searching related tags}.
#' @seealso \code{\link{fredr_tags}}
#'
#' @examples
#' \dontrun{
#' library(fredr)
#' fredr_search("oil", order_by = "popularity")
#' fredr_search_id("UNRATE", order_by = "popularity")
#' fredr_search_tags("gnp")
#' fredr_search_rel_tags("gnp", "usa")
#' }
#' @name fredr_search
#' @export
fredr_search <- function(search_text = NULL,
                         limit = 100000L,
                         offset = 0,
                         order_by = NULL,
                         sort_order = "asc",
                         filter_variable = NULL,
                         filter_value = NULL,
                         realtime_start = NULL,
                         realtime_end = NULL) {

  args <- capture_fred_args(
    search_text = search_text,
    limit = limit,
    offset = offset,
    order_by = order_by,
    sort_order = sort_order,
    filter_variable = filter_variable,
    filter_value = filter_value,
    realtime_start = realtime_start,
    realtime_end = realtime_end
  )

  if(is.null(search_text)) {
    stop("Argument `search_text` must be supplied.", call. = FALSE)
  }

  fredr_args <- list(endpoint = "series/search", search_type = "full_text")

  do.call(fredr, c(fredr_args, args))
}

#' @rdname fredr_search
#' @export
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
#' @export
fredr_search_tags <- function(series_search_text = NULL, ...) {
  stopifnot(!is.null(series_search_text))
  fredr::fredr(
    endpoint = "series/search/tags",
    series_search_text = series_search_text,
    ...
  )
}

#' @rdname fredr_search
#' @export
fredr_search_rel_tags <- function(series_search_text = NULL, tag_names = NULL, ...) {
  stopifnot(!is.null(series_search_text), !is.null(tag_names))
  fredr::fredr(
    endpoint = "series/search/related_tags",
    series_search_text = series_search_text,
    tag_names = tag_names,
    ...
  )
}
