test_that("fredr_source_releases()", {
  skip_if_no_key()

  src <- fredr_source_releases(source_id = 1L, limit = 10L)

  expect_s3_class(src, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(src) == 7)
  expect_true(nrow(src) == 10)
})

test_that("input is validated", {
  expect_error(fredr_source(source_id = "a"))
  expect_error(fredr_source(source_id = 1:2))
})
