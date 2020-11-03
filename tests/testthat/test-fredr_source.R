test_that("fredr_source()", {
  skip_if_no_key()

  expect_silent(src <- fredr_source(source_id = 1L))
  expect_s3_class(src, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(src) == 5)
  expect_true(nrow(src) == 1)
})

test_that("input is validated", {
  expect_error(fredr_source(source_id = "a"), "single finite integer")
  expect_error(fredr_source(source_id = 1:2), "single finite integer")
})
