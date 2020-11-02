test_that("fredr_series_search_tags()", {
  skip_if_no_key()

  expect_silent(search <- fredr_series_search_tags(series_search_text = "oil", limit = 5L))
  expect_s3_class(search, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(search) == 6)
})

test_that("input is validated", {
  expect_error(fredr_series_search_tags())
  expect_error(fredr_series_search_tags(series_search_text = 1))
  expect_error(fredr_series_search_tags(series_search_text = c("a", "b")))
})
