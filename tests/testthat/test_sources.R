library(fredr)
context("Endpoint functions: Sources")

test_that("fredr_sources()", {
  skip_if_no_key()
  expect_silent(srcs <- fredr_sources(limit = 10L))
  expect_s3_class(srcs, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(srcs) == 5)
  expect_true(nrow(srcs) == 10)
})

test_that("fredr_source()", {
  skip_if_no_key()
  expect_silent(src <- fredr_source(source_id = 1L))
  expect_s3_class(src, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(src) == 5)
  expect_true(nrow(src) == 1)
  # errors
  expect_error(fredr_source(source_id = "a"))
  expect_error(fredr_source(source_id = 1:2))
})

test_that("fredr_source_releases()", {
  skip_if_no_key()
  expect_silent(src <- fredr_source_releases(source_id = 1L, limit = 10L))
  expect_s3_class(src, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(src) == 7)
  expect_true(nrow(src) == 10)
  # errors
  expect_error(fredr_source(source_id = "a"))
  expect_error(fredr_source(source_id = 1:2))
})
