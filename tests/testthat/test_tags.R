# Mock API status: [x]
# httptest::start_capturing()
# readRenviron(here::here(".Renviron"))
# fredr::fredr_set_key(Sys.getenv("FRED_API_KEY"))
# fredr_tags(limit = 20L)
# fredr_related_tags(tag_names = "gdp", limit = 20L)
# fredr_tags_series(tag_names = "gdp", limit = 20L)
# httptest::stop_capturing()
library(fredr)
context("Endpoint functions: Tags")

tbl_class <- c("tbl_df", "tbl", "data.frame")

httptest::with_mock_api({
  test_that("fredr_tags()", {
    skip_if_no_key()
    tags <- fredr_tags(limit = 20L)
    expect_s3_class(tags, tbl_class)
    expect_true(ncol(tags) == 6)
    expect_true(nrow(tags) == 20)
  })
})

httptest::with_mock_api({
  test_that("fredr_related_tags()", {
    skip_if_no_key()
    tags <- fredr_related_tags(tag_names = "gdp", limit = 20L)
    expect_s3_class(tags, tbl_class)
    expect_error(fredr_related_tags())
    expect_error(fredr_related_tags(foo = "bar"))
    expect_error(fredr_related_tags(tag_names = 1))
    expect_error(fredr_related_tags(tag_names = c("a", "b")))
    expect_true(ncol(tags) == 6)
    expect_true(nrow(tags) == 20)
  })
})


httptest::with_mock_api({
  test_that("fredr_tags_series()", {
    skip_if_no_key()
    tags <- fredr_tags_series(tag_names = "gdp", limit = 20L)
    expect_s3_class(tags, tbl_class)
    expect_error(fredr_tags_series())
    expect_error(fredr_tags_series(foo = "bar"))
    expect_error(fredr_tags_series(tag_names = 1))
    expect_error(fredr_tags_series(tag_names = c("a", "b")))
    expect_true(ncol(tags) == 16)
    expect_true(nrow(tags) == 20)
  })
})


