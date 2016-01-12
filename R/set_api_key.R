# ------------------------------------------------------------------------------
# Sets the FRED API key to .Renviron file in working directory.
# ------------------------------------------------------------------------------
#' Sets the FRED API key to .Renviron file in working directory.
#'
#' @param api_key A FRED API key as a string.  Obtain one at 
#'				https://api.stlouisfed.org/api_key.html.
#' @export
set_api_key <- function(api_key) {
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
}
