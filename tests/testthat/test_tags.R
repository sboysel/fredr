library(fredr)
context("Endpoint functions: Tags")

test_that("fredr_tags()", {
  expect_silent(tags <- fredr_tags(limit = 20L))
  expect_s3_class(tags, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(tags) == 6)
  expect_true(nrow(tags) == 20)
})
