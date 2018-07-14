library(fredr)
context("Endpoint functions: Series (miscellaneous)")

test_that("fredr_series()", {
  skip_if_no_key()
  expect_silent(series <- fredr_series(series_id = "GNPCA"))
  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 15)
  expect_true(nrow(series) == 1)
})

test_that("fredr_series_categories()", {
  skip_if_no_key()
  expect_silent(series <- fredr_series_categories(series_id = "GNPCA"))
  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 3)
  expect_true(nrow(series) == 1)
})

test_that("fredr_series_release()", {
  skip_if_no_key()
  expect_silent(series <- fredr_series_release(series_id = "GNPCA"))
  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 6)
  expect_true(nrow(series) == 1)
})

test_that("fredr_series_tags()", {
  skip_if_no_key()
  expect_silent(series <- fredr_series_tags(series_id = "GNPCA"))
  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 6)
})

test_that("fredr_series_updates()", {
  skip_if_no_key()
  expect_silent(series <- fredr_series_updates(limit = 10L))
  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 15)
  expect_true(nrow(series) == 10)
})

test_that("fredr_series_vintagedates()", {
  skip_if_no_key()
  expect_silent(series <- fredr_series_vintagedates(series_id = "GNPCA", limit = 10L))
  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  # expect_s3_class(series$vintage_dates, "Date")
  expect_true(ncol(series) == 1)
})
