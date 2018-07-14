library(fredr)
context("Endpoint functions: Series (search functions)")

test_that("fredr_series_search_text()", {
  skip_if_no_key()
  expect_silent(search <- fredr_series_search_text(search_text = "oil", limit = 20L))
  expect_s3_class(search, c("tbl_df", "tbl", "data.frame"))
  expect_error(fredr_series_search_text())
  expect_error(fredr_series_search_text(foo = "bar"))
  expect_error(fredr_series_search_text(series_search_text = "bar"))
  expect_error(fredr_series_search_text(search_text = 1))
  expect_error(fredr_series_search_text(search_text = c("a", "b")))
  expect_true(ncol(search) == 16)
})

test_that("fredr_series_search_id()", {
  skip_if_no_key()
  expect_silent(search <- fredr_series_search_id(search_text = "GNPCA", limit = 20L))
  expect_s3_class(search, c("tbl_df", "tbl", "data.frame"))
  expect_error(fredr_series_search_id())
  expect_error(fredr_series_search_id(foo = "bar"))
  expect_error(fredr_series_search_id(series_search_text = "bar"))
  expect_error(fredr_series_search_id(search_text = 1))
  expect_error(fredr_series_search_id(search_text = c("a", "b")))
  expect_true(ncol(search) == 16)
})

test_that("fredr_series_search_tags()", {
  skip_if_no_key()
  expect_silent(search <- fredr_series_search_tags(series_search_text = "oil", limit = 20L))
  expect_s3_class(search, c("tbl_df", "tbl", "data.frame"))
  expect_error(fredr_series_search_tags())
  expect_error(fredr_series_search_tags(foo = "bar"))
  expect_error(fredr_series_search_tags(search_text = "bar"))
  expect_error(fredr_series_search_tags(series_search_text = 1))
  expect_error(fredr_series_search_tags(series_search_text = c("a", "b")))
  expect_true(ncol(search) == 6)
})

test_that("fredr_series_search_related_tags()", {
  skip_if_no_key()
  expect_silent(search <- fredr_series_search_related_tags(
    series_search_text = "oil",
    tag_names = "usa",
    limit = 20L
  ))
  expect_s3_class(search, c("tbl_df", "tbl", "data.frame"))
  expect_error(fredr_series_search_related_tags())
  expect_error(fredr_series_search_related_tags(foo = "bar"))
  expect_error(fredr_series_search_related_tags(series_search_text = "foo"))
  expect_error(fredr_series_search_related_tags(tag_names = "bar"))
  expect_error(fredr_series_search_related_tags(series_search_text = 1, tag_names = 1))
  expect_error(fredr_series_search_related_tags(series_search_text = c("a", "b"), tag_names = c("a", "b")))
  expect_true(ncol(search) == 6)
})
