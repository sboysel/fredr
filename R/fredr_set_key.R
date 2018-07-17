#' Set the FRED API key
#'
#' Users of the `fredr`` package must authenticate with the FRED API by use of
#' an API key. The function `fredr_set_key()` sets the FRED API key as an
#' environment variable for use with the service.  For persistence across sessions,
#' see Details section.
#'
#' @param key A valid FRED API key as a string.  Obtain one at the
#'				[API Keys](https://api.stlouisfed.org/api_key.html) page.
#'
#' @details `fredr_set_key()` sets a key as an environment variable for use with
#' the `fredr`` package in the current session.  The key can also be set in the
#' `.Renviron` file in the working directory.  You can edit the file manually by
#' appending the line `FRED_API_KEY = my_api_ky`, where `my_api_key` is your
#' actual key.  The function `usethis::edit_r_environ()` does this safely.  Run
#' `base::readRenviron(".Renviron")` to set the key in the current session; the
#' variable will be set in subsequent sessions started in the working directory.
#'
#' @references See St. Louis Fed Web Services [API Keys](https://api.stlouisfed.org/api_key.html)
#' to obtain an API key.
#' @seealso Note that by using a FRED API key, you agree to the FRED API
#' [Terms of Use](https://research.stlouisfed.org/docs/api/terms_of_use.html).
#'
#' @examples
#' \dontrun{
#' library(fredr)
#' fredr_set_key("abcdefghijklmnopqrstuvwxyz123456")
#' }
#'
#' @export
fredr_set_key <- function(key) {
  Sys.setenv(FRED_API_KEY = key)
}
