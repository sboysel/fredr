#' Get the series in a category
#'
#' @param category_id An integer ID for the category.  Default is `0` for the
#' root category. _Required parameter._
#'
#' @param limit An positive integer indicating maximum number of results to return.  Possible
#' values are any integer between `1` and `1000` (default), inclusive.
#'
#' @param offset An non-negative integer used in conjunction with `limit` for
#' long series.  This mimics the idea of _pagination_ to retrieve large amounts
#' of data over multiple calls. Defaults to `0`.
#'
#' @param order_by A string indicating an attribute by which the results are
#' ordered by. Possible values include:
#'
#' * `"series_id"` (default)
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
#' @param sort_order A string representing the order of the resulting series.
#' Possible values are: `"asc"` (default), and `"desc"`.
#'
#' @param filter_variable A string indicating which attribute to indicate the
#' attribute that results are filtered by.  Possible values include: `"frequency"`,
#' `"units"`, `"seasonal_adjustment"`.  No filtering by default.
#'
#' @param filter_value A string giving the value of the `filter_variable`
#' attribute to filter results by.  `filter_variable` must be set.  No filtering
#' by default.
#'
#' @param tag_names A string indicating which series tags to match.  Multiple
#' tags can be delimited by a semicolon in a single string (e.g. `"usa;gnp"``).
#'
#' @param exclude_tag_names A string indicating which series tags should _not_
#' be matched.  Multiple tags can be delimited by a semicolon in a single string
#' (e.g. `"usa;gnp"``).
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#' Defaults to today's date. For more information, see
#' [Real-Time Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/category/series](https://research.stlouisfed.org/docs/api/fred/category_series.html)
#'
#' @seealso [fredr_category()], [fredr_category_children()], [fredr_category_related()],
#'  [fredr_category_tags()], [fredr_category_related_tags()]
#'
#' @examples
#' \dontrun{
#' fredr_category_series(category_id = 1L, limit = 10L)
#' }
#' @export
fredr_category_series <- function(category_id = 0L,
                                  limit = NULL,
                                  offset = NULL,
                                  order_by = NULL,
                                  sort_order = NULL,
                                  filter_variable = NULL,
                                  filter_value = NULL,
                                  tag_names = NULL,
                                  exclude_tag_names = NULL,
                                  realtime_start = NULL,
                                  realtime_end = NULL) {

  validate_category_id(category_id)

  user_args <- capture_args(
    category_id,
    realtime_start,
    realtime_end,
    limit,
    offset,
    order_by,
    sort_order,
    filter_variable,
    filter_value,
    tag_names,
    exclude_tag_names
  )

  fredr_args <- list(
    endpoint = "category/series"
  )

  do.call(fredr, c(fredr_args, user_args))

}
