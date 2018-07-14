library(fredr)
context("Core functions")

tbl_class <- c("tbl_df", "tbl", "data.frame")

test_that("fredr() throws proper errors and messages", {
  skip_if_no_key()
  # unset API key
  key_backup <- Sys.getenv("FRED_API_KEY")
  fredr_set_key("")
  expect_error(fredr(endpoint = "series"))
  fredr_set_key(key_backup)
  # print HTTP request
  expect_message(
    fredr(endpoint = "series", series_id = "GNPCA", print_req = TRUE),
    regexp = "GNPCA"
  )
  # bad endpoint
  expect_error(fredr(endpoint = "foo"))
  # bad request
  expect_error(
    fredr(endpoint = "series/observations", series_id = "bad_series_id"),
    regexp = "400: Bad Request"
  )
})

test_that("fredr() returns proper objects", {
  skip_if_no_key()
  expect_silent(resp <- fredr(endpoint = "series", series_id = "GNPCA", to_frame = FALSE))
  expect_silent(frame <- fredr(endpoint = "series", series_id = "GNPCA"))
  expect_s3_class(resp, "response")
  expect_s3_class(frame, tbl_class)
})

test_that("fredr() endpoints", {
  skip_if_no_key()
  # categories
  expect_s3_class(fredr(endpoint = "category"), tbl_class)
  expect_s3_class(fredr(endpoint = "category/children"), tbl_class)
  expect_s3_class(fredr(endpoint = "category/related"), tbl_class)
  expect_s3_class(fredr(endpoint = "category/series"), tbl_class)
  expect_s3_class(fredr(endpoint = "category/tags",
                        category_id = 0), tbl_class)
  expect_s3_class(fredr(endpoint = "category/related_tags",
                        category_id = 0, tag_names = "gnp"), tbl_class)
  # series
  expect_s3_class(fredr(endpoint = "series",
                        series_id = "GNPCA"), tbl_class)
  expect_s3_class(fredr(endpoint = "series/search",
                        search_text = "gnp", limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "series/updates",
                        limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "series/categories",
                        series_id = "GNPCA", limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "series/search/tags",
                        series_search_text = "gnp", limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "series/search/related_tags",
                        series_search_text = "gnp",
                        tag_names = "usa", limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "series/release",
                        series_id = "GNPCA", limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "series/observations",
                        series_id = "GNPCA", limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "series/vintagedates",
                        series_id = "GNPCA", limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "series/tags",
                        series_id = "GNPCA", limit = 10), tbl_class)
  # source
  expect_s3_class(fredr(endpoint = "source",
                        source_id = 1), tbl_class)
  expect_s3_class(fredr(endpoint = "sources",
                        limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "source/releases",
                        source_id = 1,
                        limit = 10), tbl_class)
  # tags
  expect_s3_class(fredr(endpoint = "tags", limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "related_tags",
                        tag_names = "gnp", limit = 10), tbl_class)
  expect_s3_class(fredr(endpoint = "tags/series",
                        tag_names = "gnp", limit = 10), tbl_class)
})

