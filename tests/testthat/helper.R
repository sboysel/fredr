library(httptest)

skip_if_no_key <- function() {
  testthat::skip_if(
    condition = identical(Sys.getenv("FRED_API_KEY"), ""),
    message = "FRED API key is not set."
  )
}

# TODO: cron job that sets environment variable MOCK_BYPASS=TRUE periodically and
# runs all requests in testing suite via Github Action
if (Sys.getenv("MOCK_BYPASS") == "true") {
  with_mock_api <- force
} else if (Sys.getenv("MOCK_BYPASS") == "capture") {
  with_mock_api <- capture_requests
}
