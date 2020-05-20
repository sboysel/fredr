# Mock API status: [x]
# httptest::start_capturing()
# readRenviron(here::here(".Renviron"))
# fredr_sources(limit = 10L)
# fredr_source(source_id = 1L)
# fredr_source_releases(source_id = 1L, limit = 10L)
# httptest::stop_capturing()
library(fredr)
context("Endpoint functions: Sources")

tbl_class <- c("tbl_df", "tbl", "data.frame")

httptest::with_mock_api({
  test_that("fredr_sources()", {
    skip_if_no_key()
    srcs <- fredr_sources(limit = 10L)
    expect_s3_class(srcs, tbl_class)
    expect_true(ncol(srcs) == 5)
    expect_true(nrow(srcs) == 10)
  })
})

httptest::with_mock_api({
  test_that("fredr_source()", {
    skip_if_no_key()
    src <- fredr_source(source_id = 1L)
    expect_s3_class(src, tbl_class)
    expect_true(ncol(src) == 5)
    expect_true(nrow(src) == 1)
    # errors
    expect_error(fredr_source(source_id = "a"))
    expect_error(fredr_source(source_id = 1:2))
  })
})

httptest::with_mock_api({
  test_that("fredr_source_releases()", {
    skip_if_no_key()
    src <- fredr_source_releases(source_id = 1L, limit = 10L)
    expect_s3_class(src, tbl_class)
    expect_true(ncol(src) == 7)
    expect_true(nrow(src) == 10)
    # errors
    expect_error(fredr_source(source_id = "a"))
    expect_error(fredr_source(source_id = 1:2))
  })
})
