# Mock API status: [x]
# httptest::start_capturing()
# readRenviron(here::here(".Renviron"))
# fredr_series_search_text(search_text = "oil", limit = 20L)
# fredr_series_search_id(search_text = "GNPCA", limit = 20L)
# fredr_series_search_tags(series_search_text = "oil", limit = 20L)
# fredr_series_search_related_tags(
#   series_search_text = "oil",
#   tag_names = "usa",
#   limit = 20L
# )
# httptest::stop_capturing()
library(fredr)
context("Endpoint functions: Series (search functions)")

tbl_class <- c("tbl_df", "tbl", "data.frame")

httptest::with_mock_api({
  test_that("fredr_series_search_text()", {
    skip_if_no_key()
    search <- fredr_series_search_text(search_text = "oil", limit = 20L)
    expect_s3_class(search, tbl_class)
    expect_error(fredr_series_search_text())
    expect_error(fredr_series_search_text(foo = "bar"))
    expect_error(fredr_series_search_text(series_search_text = "bar"))
    expect_error(fredr_series_search_text(search_text = 1))
    expect_error(fredr_series_search_text(search_text = c("a", "b")))
    expect_true(ncol(search) == 16)
  })
})

httptest::with_mock_api({
  test_that("fredr_series_search_id()", {
    skip_if_no_key()
    search <- fredr_series_search_id(search_text = "GNPCA", limit = 20L)
    expect_s3_class(search, tbl_class)
    expect_error(fredr_series_search_id())
    expect_error(fredr_series_search_id(foo = "bar"))
    expect_error(fredr_series_search_id(series_search_text = "bar"))
    expect_error(fredr_series_search_id(search_text = 1))
    expect_error(fredr_series_search_id(search_text = c("a", "b")))
    expect_true(ncol(search) == 16)
  })
})

httptest::with_mock_api({
  test_that("fredr_series_search_tags()", {
    skip_if_no_key()
    search <- fredr_series_search_tags(series_search_text = "oil", limit = 20L)
    expect_s3_class(search, tbl_class)
    expect_error(fredr_series_search_tags())
    expect_error(fredr_series_search_tags(foo = "bar"))
    expect_error(fredr_series_search_tags(search_text = "bar"))
    expect_error(fredr_series_search_tags(series_search_text = 1))
    expect_error(fredr_series_search_tags(series_search_text = c("a", "b")))
    expect_true(ncol(search) == 6)
  })
})

httptest::with_mock_api({
  test_that("fredr_series_search_related_tags()", {
    skip_if_no_key()
    search <- fredr_series_search_related_tags(
      series_search_text = "oil",
      tag_names = "usa",
      limit = 20L
    )
    expect_s3_class(search, tbl_class)
    expect_error(fredr_series_search_related_tags())
    expect_error(fredr_series_search_related_tags(foo = "bar"))
    expect_error(fredr_series_search_related_tags(series_search_text = "foo"))
    expect_error(fredr_series_search_related_tags(tag_names = "bar"))
    expect_error(fredr_series_search_related_tags(series_search_text = 1, tag_names = 1))
    expect_error(fredr_series_search_related_tags(series_search_text = c("a", "b"), tag_names = c("a", "b")))
    expect_true(ncol(search) == 6)
  })
})
