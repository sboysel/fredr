test_that("fredr_sources()", {
  skip_if_no_key()

  srcs <- fredr_sources(limit = 10L)

  expect_s3_class(srcs, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(srcs) == 5)
  expect_true(nrow(srcs) == 10)
})
