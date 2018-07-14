library(fredr)
context("Endpoint functions: Series (observations)")

test_that("fredr_series_observations() returns proper object", {
  skip_if_no_key()
  expect_silent(series <- fredr_series_observations(series_id = "GNPCA", limit = 20L))
  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_s3_class(series$date, "Date")
  expect_type(series[[2]], "double")
  expect_true(ncol(series) == 2)
  expect_true(nrow(series) == 20)
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
