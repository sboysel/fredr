#' List of available FRED API endpoints.
#'
#' @format A data frame with 31 rows and 3 variables:
#' \describe{
#'   \item{type}{endpoint type (e.g. "Categories", "Releases", "Series", "Sources", and "Tags".)}
#'   \item{endpoint}{endpoint name (e.g. "fred/category", "fredr/series/observations", "fredr/tags").
#'   This name can be supplied to the \code{endpoint} parameter in \code{\link[fredr]{fredr_docs}} to
#'   open the \href{https://api.stlouisfed.org/docs/fred/}{FRED API endpoint documentation} in a web browser.}
#'   \item{note}{endpoint details}
#' }
#'
#' @source \url{https://api.stlouisfed.org/docs/fred/}.
#' @seealso [fredr]
"fredr_endpoints"
