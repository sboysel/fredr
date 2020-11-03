#' Get the child categories for a specified FRED parent category
#'
#' @param category_id An integer ID for the category.  Default is `0` for the
#'   root category. _Required parameter._
#'
#' @param realtime_start A `Date` indicating the start of the real-time period.
#'   Defaults to today's date. For more information, see [Real-Time
#'   Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @param realtime_end A `Date` indicating the end of the real-time period.
#'   Defaults to today's date. For more information, see [Real-Time
#'   Periods](https://research.stlouisfed.org/docs/api/fred/realtime_period.html).
#'
#' @return A `tibble` object containing the name and ID for the children
#'   categories of the parent category indicated by `category_id`.
#'
#' @section API Documentation:
#'
#'   [fred/category/children](https://research.stlouisfed.org/docs/api/fred/category_children.html)
#'
#' @seealso [fredr_category()], [fredr_category_related()],
#'   [fredr_category_series()], [fredr_category_tags()],
#'   [fredr_category_related_tags()]
#'
#' @examples
#' if (fredr_has_key()) {
#' # Children of the root category
#' fredr_category_children(category_id = 0L)
#' # Children of the "Production & Business Activity" category
#' fredr_category_children(category_id = 1L)
#' }
#' @export
fredr_category_children <- function(category_id = 0L,
                                    realtime_start = NULL,
                                    realtime_end = NULL) {

  validate_category_id(category_id)

  user_args <- capture_args(
    category_id = category_id,
    realtime_start = realtime_start,
    realtime_end = realtime_end
  )

  fredr_args <- list(
    endpoint = "category/children"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
