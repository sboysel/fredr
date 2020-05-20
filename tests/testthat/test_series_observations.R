# Mock API status: [x]
# httptest::start_capturing()
# readRenviron(here::here(".Renviron"))
# fredr::fredr_set_key(Sys.getenv("FRED_API_KEY"))
# fredr_series_observations(series_id = "GNPCA", limit = 20L)
# fredr::fredr_series_observations(
#   series_id = "GNPCA",
#   observation_start = as.Date("2050-01-01")
# )
# httptest::stop_capturing()
library(fredr)
context("Endpoint functions: Series (observations)")

tbl_class <- c("tbl_df", "tbl", "data.frame")

httptest::with_mock_api({
  test_that("fredr_series_observations() returns proper object", {
    skip_if_no_key()
    series <- fredr_series_observations(series_id = "GNPCA", limit = 20L)
    expect_s3_class(series, tbl_class)
    expect_s3_class(series$date, "Date")
    expect_type(series[[2]], "character")
    expect_type(series[[3]], "double")
    expect_true(ncol(series) == 3)
    expect_true(nrow(series) == 20)
  })
})

httptest::with_mock_api({
  test_that("fredr_series_observations() properly returns zero row tibble", {
    skip_if_no_key()
    series <- fredr::fredr_series_observations(
      series_id = "GNPCA",
      observation_start = as.Date("2050-01-01")
    )
    expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
    expect_true(ncol(series) == 3)
    expect_true(nrow(series) == 0)
  })
})

test_that("fredr_series_observations() throws errors for bad parameters", {
  skip_if_no_key()
  expect_error(fredr_series_observations())
  expect_error(fredr_series_observations(foo = "bar"))
  expect_error(fredr_series_observations(series_id = 1))
  expect_error(fredr_series_observations(series_id = c("a", "b")))
})

test_that("validate_series_id() throws proper errors", {
  skip_if_no_key()
  expect_error(validate_series_id())
  expect_error(validate_series_id(NULL))
  expect_error(validate_series_id(1))
  expect_error(validate_series_id(c("a", "b")))
})
