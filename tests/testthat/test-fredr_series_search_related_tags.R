test_that("fredr_series_search_related_tags()", {
  skip_if_no_key()

  expect_silent(search <- fredr_series_search_related_tags(
    series_search_text = "oil",
    tag_names = "usa",
    limit = 5L
  ))

  expect_s3_class(search, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(search) == 6)
})

test_that("input is validated", {
  expect_error(fredr_series_search_related_tags())
  expect_error(fredr_series_search_related_tags(series_search_text = 1, tag_names = 1))
  expect_error(fredr_series_search_related_tags(series_search_text = c("a", "b"), tag_names = c("a", "b")))
})

test_that("must supply both tag_names and series_search_text", {
  expect_error(fredr_series_search_related_tags(series_search_text = "foo"))
  expect_error(fredr_series_search_related_tags(tag_names = "bar"))
})
