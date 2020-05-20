# Mock API status: [x]
# options(httptest.verbose=TRUE)
# httptest::start_capturing()
# readRenviron(here::here(".Renviron"))
# fredr::fredr_set_key(Sys.getenv("FRED_API_KEY"))
# fredr_category(category_id = 10L)
# fredr_category_children(category_id = 0L)
# fredr_category_related(category_id = 1L)
# fredr_category_series(category_id =  0L)
# fredr_category_tags(category_id = 0L)
# fredr_category_related_tags(category_id = 0L, tag_names = "gnp")
# httptest::stop_capturing()
library(fredr)
context("Endpoint functions: Categories")

tbl_class <- c("tbl_df", "tbl", "data.frame")

httptest::with_mock_api({
  test_that("fredr_category()", {
    skip_if_no_key()
    # expect_silent()
    ctg <- fredr_category(category_id = 10L)
    expect_s3_class(ctg, tbl_class)
    expect_true(ncol(ctg) == 3)
    expect_true(nrow(ctg) == 1)
    # errors
    expect_error(fredr_category(category_id = NULL))
    expect_error(fredr_category(category_id = "a"))
    expect_error(fredr_category(category_id = 1:2))
  })
})

httptest::with_mock_api({
  test_that("fredr_category_children()", {
    skip_if_no_key()
    # expect_silent()
    ctg <- fredr_category_children(category_id = 0L)
    expect_s3_class(ctg, tbl_class)
    expect_true(ncol(ctg) == 3)
    expect_true(nrow(ctg) == 8)
    # errors
    expect_error(fredr_category_children(category_id = NULL))
    expect_error(fredr_category_children(category_id = "a"))
    expect_error(fredr_category_children(category_id = 1:2))
  })
})

httptest::with_mock_api({
  test_that("fredr_category_related()", {
    skip_if_no_key()
    # expect_silent()
    ctg <- fredr_category_related(category_id = 1L)
    expect_s3_class(ctg, tbl_class)
    expect_true(ncol(ctg) == 0)
    expect_true(nrow(ctg) == 0)
    # errors
    expect_error(fredr_category_related(category_id = NULL))
    expect_error(fredr_category_related(category_id = "a"))
    expect_error(fredr_category_related(category_id = 1:2))
  })
})

httptest::with_mock_api({
  test_that("fredr_category_series()", {
    skip_if_no_key()
    # expect_silent()
    ctg <- fredr_category_series(category_id = 0L)
    expect_s3_class(ctg, tbl_class)
    expect_true(ncol(ctg) == 0)
    expect_true(nrow(ctg) == 0)
    # errors
    expect_error(fredr_category_series(category_id = NULL))
    expect_error(fredr_category_series(category_id = "a"))
    expect_error(fredr_category_series(category_id = 1:2))
  })
})

httptest::with_mock_api({
  test_that("fredr_category_tags()", {
    skip_if_no_key()
    # expect_silent()
    ctg <- fredr_category_tags(category_id = 0L)
    expect_s3_class(ctg, tbl_class)
    expect_true(ncol(ctg) == 0)
    expect_true(nrow(ctg) == 0)
    # errors
    expect_error(fredr_category_tags(category_id = NULL))
    expect_error(fredr_category_tags(category_id = "a"))
    expect_error(fredr_category_tags(category_id = 1:2))
  })
})

httptest::with_mock_api({
  test_that("fredr_category_related_tags()", {
    skip_if_no_key()
    # expect_silent()
    ctg <- fredr_category_related_tags(category_id = 0L, tag_names = "gnp")
    expect_s3_class(ctg, tbl_class)
    expect_true(ncol(ctg) == 0)
    expect_true(nrow(ctg) == 0)
    # errors
    expect_error(fredr_category_related_tags(category_id = NULL, tag_names = "gnp"))
    expect_error(fredr_category_related_tags(category_id = "a", tag_names = "gnp"))
    expect_error(fredr_category_related_tags(category_id = 1:2, tag_names = "gnp"))
    expect_error(fredr_category_related_tags(category_id = 0, tag_names = NULL))
    expect_error(fredr_category_related_tags(category_id = 0, tag_names = NA))
    expect_error(fredr_category_related_tags(category_id = 0, tag_names = 1))
    expect_error(fredr_category_related_tags(category_id = 0, tag_names = c("a", "b")))
  })
})
