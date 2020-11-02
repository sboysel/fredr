skip_if_no_key <- function() {
  testthat::skip_if(
    condition = identical(Sys.getenv("FRED_API_KEY"), ""),
    message = "FRED API key is not set."
  )
}
