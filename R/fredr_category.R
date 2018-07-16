#' Get a category
#'
#' @param category_id An integer ID for the category.  Default is `0` for the
#' root category. _Required parameter._
#'
#' @return A `tibble` object.
#'
#' @section API Documentation:
#'
#' [fred/category](https://research.stlouisfed.org/docs/api/fred/category.html)
#'
#' @seealso [fredr_category_children()], [fredr_category_related()],
#' [fredr_category_series()], [fredr_category_tags()], [fredr_category_related_tags()]
#'
#' @examples
#' \dontrun{
#' fredr_category()
#' }
#' @export
fredr_category <- function(category_id = 0L) {

  validate_category_id(category_id)

  user_args <- capture_args(
    category_id
  )

  fredr_args <- list(
    endpoint = "category"
  )

  do.call(fredr, c(fredr_args, user_args))

}
