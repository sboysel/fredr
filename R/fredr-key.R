#' FRED API key
#'
#' @description
#' Users of fredr must authenticate with the FRED API by use of an
#' API key. This key should be stored as an environment variable,
#' `FRED_API_KEY`.
#'
#' - `fredr_get_key()` will retrieve the key, if set, or it will return `NULL`
#'   if the key is unset.
#'
#' - `fredr_set_key()` will set the key _for the current R session_. For
#'   persistence across sessions, set the environment variable.
#'   See the Details section for more information.
#'
#' @param key A valid FRED API key as a string. Obtain one at the [API
#'   Keys](https://api.stlouisfed.org/api_key.html) page. Can also be `NULL`
#'   to unset the key for the current R session.
#'
#' @details
#'   The preferred method to set the key is to set the `FRED_API_KEY`
#'   environment variable in an `.Renviron` file. The easiest way to do this is
#'   by calling `usethis::edit_r_environ()`. Don't forget to restart R after
#'   setting the key.
#'
#' @references See St. Louis Fed Web Services [API
#'   Keys](https://api.stlouisfed.org/api_key.html) to obtain an API key.
#'
#' @seealso Note that by using a FRED API key, you agree to the FRED API [Terms
#'   of Use](https://research.stlouisfed.org/docs/api/terms_of_use.html).
#'
#' @name fredr-key
#'
#' @examples
#' original_key <- fredr_get_key()
#'
#' # Set a once per session key
#' fredr_set_key("foo")
#'
#' # Get it
#' fredr_get_key()
#'
#' # Reset to original key
#' fredr_set_key(original_key)
NULL

#' @export
#' @rdname fredr-key
fredr_set_key <- function(key) {
  if (!is_string(key) && !is_null(key)) {
    abort("`key` must be a string or `NULL`.")
  }

  if (is_null(key)) {
    Sys.unsetenv("FRED_API_KEY")
  } else {
    Sys.setenv(FRED_API_KEY = key)
  }
}

#' @export
#' @rdname fredr-key
fredr_get_key <- function() {
  key <- Sys.getenv("FRED_API_KEY", unset = "")

  if (identical(key, "")) {
    NULL
  } else {
    key
  }
}
