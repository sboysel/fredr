test_that("fredr_series_categories()", {
  skip_if_no_key()

  series <- fredr_series_categories(series_id = "GNPCA")

  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 3)
  expect_true(nrow(series) == 1)
})
