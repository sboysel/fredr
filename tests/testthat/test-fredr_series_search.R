test_that("fredr_series_search_text()", {
  skip_if_no_key()

  search <- fredr_series_search_text(search_text = "oil", limit = 20L)

  expect_s3_class(search, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(search) == 16)
})

test_that("input is validated", {
  expect_error(fredr_series_search_text())
  expect_error(fredr_series_search_text(search_text = 1))
  expect_error(fredr_series_search_text(search_text = c("a", "b")))
})

test_that("fredr_series_search_id()", {
  skip_if_no_key()

  search <- fredr_series_search_id(search_text = "GNPCA", limit = 20L)

  expect_s3_class(search, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(search) == 16)
})

test_that("input is validated", {
  expect_error(fredr_series_search_id())
  expect_error(fredr_series_search_id(search_text = 1))
  expect_error(fredr_series_search_id(search_text = c("a", "b")))
})
