#' Set the FRED API key
#'
#' Users \code{fredr} package must authenticate with the FRED API by use of an API key.
#' The function \code{fredr_key} sets the FRED API key for use with the service.  The key is cached in an
#' \code{.Renviron} in the current working directory.  The function gives a message and invisibly
#' returns the key when it is already set.  See Details section for more information.
#'
#' @param api_key A FRED API key as a string.  Obtain one at
#'				\url{https://api.stlouisfed.org/api_key.html}.
#'
#' @return invisibly returns the value of the set API key as a string.
#'
#' @details \code{fredr_key} determines if the environment variable \code{FRED_API_KEY}
#' is set.  If it is, \code{fredr_key()} gives a message and invisibly returns the key.
#' If \code{FRED_API_KEY} is not set, writes \code{api_key} to the file \code{.Renviron},
#' if it does not exist.  If \code{.Renviron} exists in the directory, \code{fredr_key}
#' throws an error. In this case, it is advised to manually add an entry
#' \code{FRED_API_KEY=api_key} to \code{.Renviron} and restart the session.  Once
#' \code{FRED_API_KEY} has been properly set as an environment variable in \code{.Renviron},
#' you can use \code{fredr} in subsequent sessions without calling \code{fredr_key} each time.
#'
#' @references See St. Louis Fed Web Services \href{https://api.stlouisfed.org/api_key.html}{API Keys} to obtain an API key.
#' @seealso Note that by using a FRED API key, you agree to the FRED API
#' \href{https://research.stlouisfed.org/docs/api/terms_of_use.html}{Terms of Use}.
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
