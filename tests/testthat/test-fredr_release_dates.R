test_that("fredr_release_dates()", {
  skip_if_no_key()

  release <- fredr_release_dates(release_id = 10L, limit = 10L)

  expect_s3_class(release, c("tbl_df", "tbl", "data.frame"))
  expect_true(ncol(release) == 2)
  expect_true(nrow(release) == 10)
})

test_that("input is validated", {
  expect_error(fredr_release_dates())
  expect_error(fredr_release_dates(release_id = "x"))
})
