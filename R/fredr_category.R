#' Get a FRED category
#'
#' @param category_id An integer ID for the category.  Default is `0` for the
#' root category. _Required parameter._
#'
#' @return A `tibble` object containing the name and parent ID for the category
#' indicated by `category_id`.
#'
#' @section API Documentation:
#'
#' [fred/category](https://research.stlouisfed.org/docs/api/fred/category.html)
#'
#' @seealso [fredr_category_children()], [fredr_category_related()],
#' [fredr_category_series()], [fredr_category_tags()], [fredr_category_related_tags()]
#'
#' @examples
#' if (fredr_has_key()) {
#' # Root category
#' fredr_category()
#' # "Production & Business Activity" category
#' fredr_category(category_id = 1L)
#' }
#' @export
fredr_category <- function(category_id = 0L) {

  validate_category_id(category_id)

  user_args <- capture_args(
    category_id = category_id
  )

  fredr_args <- list(
    endpoint = "category"
  )

  do.call(fredr_request, c(fredr_args, user_args))

}
