test_that("fredr_releases()", {
  skip_if_no_key()

  expect_silent(release <- fredr_releases(limit = 10L))
  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 7)
  expect_true(nrow(release) == 10)
})
