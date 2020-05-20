# Mock API status: [x]
# httptest::start_capturing()
# readRenviron(here::here(".Renviron"))
# fredr::fredr_set_key(Sys.getenv("FRED_API_KEY"))
# fredr_series(series_id = "GNPCA")
# fredr_series_categories(series_id = "GNPCA")
# fredr_series_release(series_id = "GNPCA")
# fredr_series_tags(series_id = "GNPCA")
# fredr_series_updates(limit = 10L)
# fredr_series_vintagedates(series_id = "GNPCA", limit = 10L)
# httptest::stop_capturing()
library(fredr)
context("Endpoint functions: Series (miscellaneous)")

tbl_class <- c("tbl_df", "tbl", "data.frame")

httptest::with_mock_api({
  test_that("fredr_series()", {
    skip_if_no_key()
    series <- fredr_series(series_id = "GNPCA")
    expect_s3_class(series, tbl_class)
    expect_true(ncol(series) == 15)
    expect_true(nrow(series) == 1)
  })
})

httptest::with_mock_api({
  test_that("fredr_series_categories()", {
    skip_if_no_key()
    series <- fredr_series_categories(series_id = "GNPCA")
    expect_s3_class(series, tbl_class)
    expect_true(ncol(series) == 3)
    expect_true(nrow(series) == 1)
  })
})

httptest::with_mock_api({
  test_that("fredr_series_release()", {
    skip_if_no_key()
    series <- fredr_series_release(series_id = "GNPCA")
    expect_s3_class(series, tbl_class)
    expect_true(ncol(series) == 6)
    expect_true(nrow(series) == 1)
  })
})

httptest::with_mock_api({
  test_that("fredr_series_tags()", {
    skip_if_no_key()
    series <- fredr_series_tags(series_id = "GNPCA")
    expect_s3_class(series, tbl_class)
    expect_true(ncol(series) == 6)
  })
})

httptest::with_mock_api({
  test_that("fredr_series_updates()", {
    skip_if_no_key()
    series <- fredr_series_updates(limit = 10L)
    expect_s3_class(series, tbl_class)
    expect_true(ncol(series) == 15)
    expect_true(nrow(series) == 10)
  })
})

httptest::with_mock_api({
  test_that("fredr_series_vintagedates()", {
    skip_if_no_key()
    series <- fredr_series_vintagedates(series_id = "GNPCA", limit = 10L)
    expect_s3_class(series, tbl_class)
    expect_true(ncol(series) == 1)
  })
})


