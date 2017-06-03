#' Set the FRED API key
#'
#' Set the FRED API key for use with \code{fredr}.  The key is cached in an
#' \code{.Renviron} in the directory.  The function gives a message and invisibly
#' returns the key when it is already set.
#'
#' @param api_key A FRED API key as a string.  Obtain one at
#'				\url{https://api.stlouisfed.org/api_key.html}.
#'
#' @return invisibly returns the value of the set API key as a string.
#'
#' @details \code{fredr_key} determines if the environment variable \code{FRED_API_KEY}
#' is set.  If it is, \code{fredr_key()} gives a message and invisibly returns the key.
#' If \code{FRED_API_KEY} is not set, writes \code{api_key} to the file \code{.Renviron},
#' if it does not exist.  If \code{.Renviron} exists in the directory, it is advised
#' to manually add an entry \code{FRED_API_KEY=api_key} and restart the session.  Once
#' \code{api_key} has been saved as an environment variable in \code{.Renviron},
#' you can use \code{fredr} in subsequent sessions without calling \code{fredr_key}.
#'
#' @references See \url{https://api.stlouisfed.org/api_key.html} to obtain an API key.
#' @seealso Note that by using a FRED API key, you agree to the FRED® API Terms of Use.
#' See \url{https://research.stlouisfed.org/docs/api/terms_of_use.html}.
#'
#' @examples
#'
#' \dontrun{
#' library(fredr)
#' fredr_key("abcdefghijklmnopqrstuvwxyz123456")
#' key <- fredr_key()
#' identical(key, "abcdefghijklmnopqrstuvwxyz123456")
#' }
#'
#' @export
fredr_key <- function(api_key) {
  if (!identical(Sys.getenv("FRED_API_KEY"), "")) {
    message("FRED API key set as environment variable.")
  } else {
    renv <- file.path(getwd(), ".Renviron")
    if (file.exists(renv)) {
      stop(paste(".Renviron file exists in directory"))
    }
    renv_conn <- file(renv)
    writeLines(c(paste0("FRED_API_KEY=", api_key), ""), renv_conn)
    close(renv_conn)
    readRenviron(renv)
    message("FRED API key successfully set. Run 'Sys.getenv('FRED_API_KEY')' to
            see key")
  }
  invisible(Sys.getenv("FRED_API_KEY"))
}
