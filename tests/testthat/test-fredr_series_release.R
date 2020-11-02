test_that("fredr_series_release()", {
  skip_if_no_key()

  expect_silent(series <- fredr_series_release(series_id = "GNPCA"))
  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 6)
  expect_true(nrow(series) == 1)
})
