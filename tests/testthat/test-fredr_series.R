test_that("fredr_series()", {
  skip_if_no_key()

  expect_silent(series <- fredr_series(series_id = "GNPCA"))
  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 15)
  expect_true(nrow(series) == 1)
})

test_that("input is validated", {
  expect_error(fredr_series())
})
