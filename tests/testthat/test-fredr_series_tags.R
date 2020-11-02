test_that("fredr_series_tags()", {
  skip_if_no_key()

  expect_silent(series <- fredr_series_tags(series_id = "GNPCA"))
  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 6)
})
