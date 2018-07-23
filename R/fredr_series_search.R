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
#' @param tag_names A semicolon delimited string of tag names that series match _all_ of.  Defaults to no tag filtering.
#'
#' @param exclude_tag_names A semicolon delimited string of tag names that
#' series match _none_ of.  Defaults to no tag filtering.
#'
#' @param filter_variable A string indicating the attribute to filter results
#' by. Possible values are: `"frequency"`, `"units"`, `"seasonal_adjustment"`.
#' Defaults to no filter.
#'
#' @param filter_value The value of the `filter_variable` attribute to filter
#' by. Possible values depend on the value of `filter_variable`. Defaults to
#' no filter.
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
#' @return A `tibble` object where each row represents a series matching the query.
#'
#' @references API Documentation:
#'
#' [series/search](https://research.stlouisfed.org/docs/api/fred/series_search.html)
#'
#' @seealso [fredr_series_observations()], [fredr_series_search_tags()],
#' [fredr_series_search_related_tags()], [fredr_series()], [fredr_series_categories()],
#' [fredr_series_release()], [fredr_series_tags()], [fredr_series_updates()],
#' [fredr_series_vintagedates()].
#'
#' @examples
#' \donttest{
#' # search for series with text matching "oil" and return the top 10 most popular
#' # series
#' fredr_series_search_text(
#'   search_text = "oil",
#'   order_by = "popularity",
#'   limit = 10
#' )
#' # search for series with text matching "oil" with the tag "usa" and return the
#' # top 10 search results
#' fredr_series_search_text(
#'   search_text = "oil",
#'   order_by = "search_rank",
#'   limit = 10,
#'   tag_names = "usa"
#' )
#' # search for series with text matching "unemployment" and return only series
#' # with monthly frequency
#' fredr_series_search_text(
#'   search_text = "unemployment",
#'   filter_variable = "frequency",
#'   filter_value = "Monthly"
#' )
#' # search for series ID matching "UNRATE" and return oldest series first
#' fredr_series_search_id(
#'   search_text = "UNRATE",
#'   order_by = "observation_start"
#' )
#' }
#' @rdname fredr_series_search
#' @export
fredr_series_search_text <- function(search_text = NULL,
                                     tag_names = NULL,
                                     exclude_tag_names = NULL,
                                     filter_variable = NULL,
                                     filter_value = NULL,
                                     limit = NULL,
                                     offset = NULL,
                                     order_by = NULL,
                                     sort_order = NULL,
                                     realtime_start = NULL,
                                     realtime_end = NULL) {

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

  do.call(fredr_request, c(fredr_args, args))
}

#' @rdname fredr_series_search
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

  do.call(fredr_request, c(fredr_args, args))
}
