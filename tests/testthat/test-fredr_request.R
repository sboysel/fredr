test_that("errors without key", {
  original <- fredr_get_key()
  on.exit(fredr_set_key(original), add = TRUE)

  fredr_set_key(NULL)
  expect_error(fredr_request(endpoint = "series"), "key must be set")
})

test_that("can print http request", {
  skip_if_no_key()

  expect_message(
    fredr_request(endpoint = "series", series_id = "GNPCA", print_req = TRUE),
    regexp = "GNPCA"
  )
})

test_that("errors on bad endpoint", {
  skip_if_no_key()

  expect_error(fredr_request(endpoint = "foo"), "not a valid endpoint")
})

test_that("errors with 400 bad request error", {
  skip_if_no_key()

  expect_error(
    fredr_request(endpoint = "series/observations", series_id = "bad_series_id"),
    "400: Bad Request"
  )
})

test_that("can return tibble", {
  skip_if_no_key()
  tbl_class <- c("tbl_df", "tbl", "data.frame")

  expect_silent(frame <- fredr_request(endpoint = "series", series_id = "GNPCA"))
  expect_s3_class(frame, tbl_class)
})

test_that("can return response object", {
  skip_if_no_key()

  expect_silent(resp <- fredr_request(endpoint = "series", series_id = "GNPCA", to_frame = FALSE))
  expect_s3_class(resp, "response")
})

test_that("can hit various endpoints", {
  skip_if_no_key()
  tbl_class <- c("tbl_df", "tbl", "data.frame")

  # categories
  expect_s3_class(fredr_request(endpoint = "category"), tbl_class)
  expect_s3_class(fredr_request(endpoint = "category/children"), tbl_class)
  expect_s3_class(fredr_request(endpoint = "category/related"), tbl_class)
  expect_s3_class(fredr_request(endpoint = "category/series"), tbl_class)
  expect_s3_class(
    fredr_request(
      endpoint = "category/tags",
      category_id = 0),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "category/related_tags",
      category_id = 0,
      tag_names = "gnp"
    ),
    tbl_class
  )
  # series
  expect_s3_class(
    fredr_request(
      endpoint = "series",
      series_id = "GNPCA"
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "series/search",
      search_text = "gnp",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "series/updates",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "series/categories",
      series_id = "GNPCA",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "series/search/tags",
      series_search_text = "gnp",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "series/search/related_tags",
      series_search_text = "gnp",
      tag_names = "usa",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "series/release",
      series_id = "GNPCA",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "series/observations",
      series_id = "GNPCA",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "series/vintagedates",
      series_id = "GNPCA",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "series/tags",
      series_id = "GNPCA",
      limit = 10
    ),
    tbl_class
  )
  # source
  expect_s3_class(
    fredr_request(
      endpoint = "source",
      source_id = 1
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "sources",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "source/releases",
      source_id = 1,
      limit = 10
    ),
    tbl_class
  )
  # tags
  expect_s3_class(
    fredr_request(
      endpoint = "tags",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "related_tags",
      tag_names = "gnp",
      limit = 10
    ),
    tbl_class
  )
  expect_s3_class(
    fredr_request(
      endpoint = "tags/series",
      tag_names = "gnp",
      limit = 10
    ),
    tbl_class
  )
})

