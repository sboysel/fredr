#' Get information about a FRED series
#'
#' Given a series ID, return information on a series as a `tibble` object.  See
#' Details section for a short description of each function.
#'
#' @inheritParams fredr_series_observations
#'
#' @param limit An integer limit on the maximum number of results to return.
#' Defaults to `1000`, the maximum.
#'
#' @param order_by A string indicating the attribute by which to order the
#' Possible values include `"series_count"` (default), `"popularity"`,
#' `"created"`, `"name"`, and `"group_id"`.
#'
#' @param filter_value Filter results by type of geographic region of economic
#' the data series.  Possible values include
#'
#' * `"all"` (default) - no filtering
#' * `"macro"` - filters results macroeconomic regions (e.g. entire countries)
#' * `"regional"` - filters results to series for regions of the United States
#' such as states, counties, and Metropolitan Statistical Areas (MSA).
#'
#' @param start_time A datetime object indicating the start time to filter series
#' updates results.
#'
#' @param end_time A datetime object indicating the start time to filter series
#' updates results.
#'
#' @return A \code{tibble} object.
#'
#' @details
#' \itemize{
#'   \item `fredr_series()` - Return basic details for a series.  Note that this
#'   function will _not_ return the actual series data.  For this functionality,
#'   see [fredr_series_observations()].
#'   \item `fredr_series_categories()` - Return the categories for a series.
#'   \item `fredr_series_release()` - Return the release for a series.
#'   \item `fredr_series_tags()` - Return the tags for a series.
#'   \item `fredr_series_updates()` - Return a set of series sorted by when
#'   observations were updated on the FRED server.
#'   \item `fredr_series_vintagedates()` - Return a sequence of dates in history
#'   when a series' data values were revised or new data values were released.
#' }
#'
#' @section API Documentation:
#' \itemize{
#'   \item [fred/series](https://research.stlouisfed.org/docs/api/fred/series.html)
#'   \item [fred/series/categories](https://research.stlouisfed.org/docs/api/fred/series_categories.html)
#'   \item [fred/series/release](https://research.stlouisfed.org/docs/api/fred/series_release.html)
#'   \item [fred/series/tags](https://research.stlouisfed.org/docs/api/fred/series_tags.html)
#'   \item [fred/series/updates](https://research.stlouisfed.org/docs/api/fred/series_updates.html)
#'   \item [fred/series/vintagedates](https://research.stlouisfed.org/docs/api/fred/series_vintagedates.html)
#' }
#'
#' @seealso [fredr_series_observations()], [fredr_series_search_text()],
#' [fredr_series_search_id()], [fredr_series_search_tags()],
#' [fredr_series_search_related_tags()].
#'
#' @examples
#' \dontrun{
#' fredr_series("UNRATE")
#' fredr_series_categories("UNRATE")
#' fredr_series_release("UNRATE")
#' fredr_series_tags("UNRATE", order_by = "group_id")
#' fredr_series_update(filter_value = "regional")
#' fredr_series_vintagedates(filter_value = "regional")
#' }
#' @rdname fred_series
#' @export
fredr_series <- function(series_id = NULL,
                         realtime_start = NULL,
                         realtime_end = NULL) {

  validate_series_id(series_id)

  user_args <- capture_args(
    series_id,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series"
  )

  do.call(fredr, c(fredr_args, user_args))

}

#' @name fred_series
#' @export
fredr_series_categories <- function(series_id = NULL,
                                    realtime_start = NULL,
                                    realtime_end = NULL) {

  validate_series_id(series_id)

  user_args <- capture_args(
    series_id,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series/categories"
  )

  do.call(fredr, c(fredr_args, user_args))

}

#' @name fred_series
#' @export
fredr_series_release <- function(series_id = NULL,
                                 realtime_start = NULL,
                                 realtime_end = NULL) {

  validate_series_id(series_id)

  user_args <- capture_args(
    series_id,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series/release"
  )

  do.call(fredr, c(fredr_args, user_args))

}

#' @name fred_series
#' @export
fredr_series_tags <- function(series_id = NULL,
                              order_by = NULL,
                              sort_order = NULL,
                              realtime_start = NULL,
                              realtime_end = NULL) {

  validate_series_id(series_id)

  user_args <- capture_args(
    series_id,
    order_by,
    sort_order,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series/tags"
  )

  do.call(fredr, c(fredr_args, user_args))

}

#' @name fred_series
#' @export
fredr_series_updates <- function(limit = NULL,
                                 offset = NULL,
                                 filter_value = NULL,
                                 start_time = NULL,
                                 end_time = NULL,
                                 realtime_start = NULL,
                                 realtime_end = NULL) {

  user_args <- capture_args(
    limit,
    offset,
    filter_value,
    start_time,
    end_time,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series/updates"
  )

  do.call(fredr, c(fredr_args, user_args))

}

#' @name fred_series
#' @export
fredr_series_vintagedates <- function(series_id = NULL,
                                      limit = NULL,
                                      offset = NULL,
                                      sort_order = NULL,
                                      realtime_start = NULL,
                                      realtime_end = NULL) {

  validate_series_id(series_id)

  user_args <- capture_args(
    series_id,
    limit,
    offset,
    sort_order,
    realtime_start,
    realtime_end
  )

  fredr_args <- list(
    endpoint = "series/vintagedates"
  )

  do.call(fredr, c(fredr_args, user_args))

}

