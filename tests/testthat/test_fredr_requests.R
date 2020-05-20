# Mock API status: [x]
# options(httptest.verbose=TRUE)
# httptest::start_capturing()
# readRenviron(here::here(".Renviron"))
# fredr_request(endpoint = "series", series_id = "GNPCA", to_frame = FALSE)
# fredr_request(endpoint = "series", series_id = "GNPCA")
# fredr_request(endpoint = "category", category_id = 0L)
# fredr_request(endpoint = "category/children", category_id = 0L)
# fredr_request(endpoint = "category/related", category_id = 0L)
# fredr_request(endpoint = "category/series", category_id = 0L)
# fredr_request(endpoint = "category/tags", category_id = 0L)
# fredr_request(endpoint = "category/related_tags", category_id = 0L, tag_names = "gnp")
# fredr_request(endpoint = "series", series_id = "GNPCA")
# fredr_request(endpoint = "series/search", search_text = "gnp", limit = 10)
# fredr_request(endpoint = "series/updates", limit = 10)
# fredr_request(endpoint = "series/categories", series_id = "GNPCA", limit = 10)
# fredr_request(endpoint = "series/search/tags", series_search_text = "gnp", limit = 10)
# fredr_request(endpoint = "series/search/related_tags", series_search_text = "gnp", tag_names = "usa", limit = 10)
# fredr_request(endpoint = "series/release", series_id = "GNPCA", limit = 10)
# fredr_request(endpoint = "series/observations", series_id = "GNPCA", limit = 10)
# fredr_request(endpoint = "series/vintagedates", series_id = "GNPCA", limit = 10)
# fredr_request(endpoint = "series/tags", series_id = "GNPCA", limit = 10)
# fredr_request(endpoint = "source", source_id = 1)
# fredr_request(endpoint = "sources", limit = 10)
# fredr_request(endpoint = "source/releases", source_id = 1, limit = 10)
# fredr_request(endpoint = "tags", limit = 10)
# fredr_request(endpoint = "related_tags", tag_names = "gnp", limit = 10)
# fredr_request(endpoint = "tags/series", tag_names = "gnp", limit = 10)
# httptest::stop_capturing()
library(fredr)
context("fredr_request()")

tbl_class <- c("tbl_df", "tbl", "data.frame")

httptest::with_mock_api({
  test_that("fredr_request() throws proper errors and messages", {
    skip_if_no_key()
    # unset API key
    key_backup <- Sys.getenv("FRED_API_KEY")
    fredr_set_key("")
    expect_error(fredr_request(endpoint = "series", retry_times = 1L))
    fredr_set_key(key_backup)
    # print HTTP request
    expect_message(
      fredr_request(endpoint = "series", series_id = "GNPCA", print_req = TRUE),
      regexp = "GNPCA"
    )
    # bad endpoint
    expect_error(fredr_request(endpoint = "foo", retry_times = 1L))
    # bad request
    expect_error(
      fredr_request(endpoint = "series/observations", series_id = "bad_series_id", retry_times = 1L),
      regexp = "400: Bad Request"
    )
  })
})

httptest::with_mock_api({
  test_that("fredr_request() returns proper objects", {
    skip_if_no_key()
    resp <- fredr_request(endpoint = "series", series_id = "GNPCA", to_frame = FALSE)
    frame <- fredr_request(endpoint = "series", series_id = "GNPCA")
    expect_s3_class(resp, "response")
    expect_s3_class(frame, tbl_class)
  })
})

httptest::with_mock_api({
  test_that("fredr_request() endpoints: categories", {
    skip_if_no_key()
    expect_s3_class(fredr_request(endpoint = "category", category_id = 0L), tbl_class)
    expect_s3_class(fredr_request(endpoint = "category/children", category_id = 0L), tbl_class)
    expect_s3_class(fredr_request(endpoint = "category/related", category_id = 0L), tbl_class)
    expect_s3_class(fredr_request(endpoint = "category/series", category_id = 0L), tbl_class)
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
  })
})

httptest::with_mock_api({
  test_that("fredr_request() endpoints: series", {
    skip_if_no_key()
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
  })
})

httptest::with_mock_api({
  test_that("fredr_request() endpoints: source", {
    skip_if_no_key()
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
  })
})

httptest::with_mock_api({
  test_that("fredr_request() endpoints: tags", {
    skip_if_no_key()
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
})
