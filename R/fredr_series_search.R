#' Search for a FRED series.
#'
#' Search FRED for a series by full text of series or by series ID.
#'
#' @inheritParams fredr_series_observations
#'
#' @param search_text A string containing the words to match against economic
#' data series. For use with \code{\link{fredr_series_search_text}} and
#' \code{\link{fredr_series_search_id}}.  _Required parameter._
#'
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `1000`, the maximum.
#'
#' @param order_by A string indicating the attribute to order results by.
#' Defaults to `"search_rank"` for [fredr_series_search_text()] and `"series_id"`
#' for [fredr_series_search_id()]. Possible values are:
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
#' @param tag_names A semicolon delimited string of tag names that series match _all_ of.  Defaults to no tag filtering.
#'
#' @param exclude_tag_names A semicolon delimited string of tag names that
#' series match _none_ of.  Defaults to no tag filtering.
#'
#' @return A \code{tibble} object.
#'
#' @references API Documentation:
#'
#' [series/search](https://research.stlouisfed.org/docs/api/fred/series_search.html)
#'
#' @seealso [fredr_series_search_tags()], [fredr_series_search_related_tags()], [fredr_tags]
#'
#' @examples
#' \dontrun{
#' library(fredr)
#' fredr_series_search_text("oil", order_by = "popularity", limit = 10)
#' fredr_series_search_text("oil", order_by = "search_rank", limit = 10, tag_names = "usa")
#' fredr_series_search_text("oil", filter_variable = "frequency", filter_value = "q")
#' fredr_series_search_id("UNRATE", order_by = "observation_start")
#' }
#' @name fredr_series_search
#' @export
fredr_series_search_text <- function(search_text = NULL,
                                     limit = 1000L,
                                     offset = 0,
                                     order_by = NULL,
                                     sort_order = "asc",
                                     filter_variable = NULL,
                                     filter_value = NULL,
                                     realtime_start = NULL,
                                     realtime_end = NULL,
                                     tag_names = NULL,
                                     exclude_tag_names = NULL) {

  validate_required_string_param(search_text)

  args <- capture_args(
    search_text = search_text,
    limit = limit,
    offset = offset,
    order_by = order_by,
    sort_order = sort_order,
    filter_variable = filter_variable,
    filter_value = filter_value,
    realtime_start = realtime_start,
    realtime_end = realtime_end,
    tag_names = tag_names,
    exclude_tag_names = exclude_tag_names
  )

  fredr_args <- list(endpoint = "series/search", search_type = "full_text")

  do.call(fredr, c(fredr_args, args))
}

#' @name fredr_series_search
#' @export
fredr_series_search_id <- function(search_text = NULL,
                                   limit = 1000L,
                                   offset = 0,
                                   order_by = NULL,
                                   sort_order = "asc",
                                   filter_variable = NULL,
                                   filter_value = NULL,
                                   realtime_start = NULL,
                                   realtime_end = NULL,
                                   tag_names = NULL,
                                   exclude_tag_names = NULL) {

  validate_required_string_param(search_text)

  args <- capture_args(
    search_text,
    limit,
    offset,
    order_by,
    sort_order,
    filter_variable,
    filter_value,
    realtime_start,
    realtime_end,
    tag_names,
    exclude_tag_names
  )

  fredr_args <- list(
    endpoint = "series/search",
    search_type = "series_id"
  )

  do.call(fredr, c(fredr_args, args))
}
