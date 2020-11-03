test_that("fredr_series_vintagedates()", {
  skip_if_no_key()

  series <- fredr_series_vintagedates(series_id = "GNPCA", limit = 10L)

  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 1)
})
