#' List of available FRED API endpoints.
#'
#' @format A `tibble` with 31 rows and 3 variables:
#' \describe{
#'   \item{endpoint}{endpoint name (e.g. "fred/category", "fredr/series/observations", "fredr/tags").
#'   This name can be supplied to the `endpoint` parameter in [fredr_docs()] to
#'   open the [FRED API endpoint documentation](https://fred.stlouisfed.org/docs/api/fred/)
#'   in a web browser.}
#'   \item{type}{endpoint type (e.g. "Categories", "Releases", "Series", "Sources", and "Tags".)}
#'   \item{note}{endpoint details}
#' }
#'
#' @section API Documentation:
#'
#' [FRED API](https://fred.stlouisfed.org/docs/api/fred/)
#'
#' @seealso [fredr_request()], [fredr_docs()]
"fredr_endpoints"
