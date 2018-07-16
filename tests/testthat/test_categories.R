library(fredr)
context("Endpoint functions: Categories")

test_that("fredr_category()", {
  skip_if_no_key()
  expect_silent(ctg <- fredr_category())
  expect_s3_class(ctg, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(ctg) == 3)
  expect_true(nrow(ctg) == 1)
  # errors
  expect_error(fredr_category(category_id = NULL))
  expect_error(fredr_category(category_id = "a"))
  expect_error(fredr_category(category_id = 1:2))
})

test_that("fredr_category_children()", {
  skip_if_no_key()
  expect_silent(ctg <- fredr_category_children())
  expect_s3_class(ctg, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(ctg) == 3)
  expect_true(nrow(ctg) == 8)
  # errors
  expect_error(fredr_category_children(category_id = NULL))
  expect_error(fredr_category_children(category_id = "a"))
  expect_error(fredr_category_children(category_id = 1:2))
})

test_that("fredr_category_related()", {
  skip_if_no_key()
  expect_silent(ctg <- fredr_category_related(category_id = 3008L))
  expect_s3_class(ctg, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(ctg) == 0)
  expect_true(nrow(ctg) == 0)
  # errors
  expect_error(fredr_category_related(category_id = NULL))
  expect_error(fredr_category_related(category_id = "a"))
  expect_error(fredr_category_related(category_id = 1:2))
})

test_that("fredr_category_series()", {
  skip_if_no_key()
  expect_silent(ctg <- fredr_category_series(category_id = 0L))
  expect_s3_class(ctg, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(ctg) == 0)
  expect_true(nrow(ctg) == 0)
  # errors
  expect_error(fredr_category_series(category_id = NULL))
  expect_error(fredr_category_series(category_id = "a"))
  expect_error(fredr_category_series(category_id = 1:2))
})

test_that("fredr_category_tags()", {
  skip_if_no_key()
  expect_silent(ctg <- fredr_category_tags(category_id = 0L))
  expect_s3_class(ctg, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(ctg) == 0)
  expect_true(nrow(ctg) == 0)
  # errors
  expect_error(fredr_category_tags(category_id = NULL))
  expect_error(fredr_category_tags(category_id = "a"))
  expect_error(fredr_category_tags(category_id = 1:2))
})

test_that("fredr_category_related_tags()", {
  skip_if_no_key()
  expect_silent(ctg <- fredr_category_related_tags(category_id = 0L, tag_names = "gnp"))
  expect_s3_class(ctg, c("tbl_df", "tbl", "data.frame"))
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
