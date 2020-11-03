test_that("fredr_series_updates()", {
  skip_if_no_key()

  series <- fredr_series_updates(limit = 10L)

  expect_s3_class(series, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(series) == 15)
  expect_true(nrow(series) == 10)
})

test_that("bad `filter_value` throws 400 error", {
  skip_if_no_key()

  expect_error(fredr_series_updates(filter_value = "x"), "400")
  expect_error(fredr_series_updates(filter_value = "x"), "is not one of the values: macro, regional, all")
})
